-- Create function for handling transaction conflicts
CREATE OR REPLACE FUNCTION update_transaction_with_version(
  p_transaction_id UUID,
  p_data JSONB,
  p_current_version INTEGER,
  p_user_id UUID
) RETURNS JSONB AS $$
DECLARE
  v_actual_version INTEGER;
  v_result JSONB;
BEGIN
  -- Get the current version
  SELECT version INTO v_actual_version 
  FROM transactions 
  WHERE id = p_transaction_id;
  
  IF v_actual_version IS NULL THEN
    RETURN jsonb_build_object('success', FALSE, 'error', 'Transaction not found');
  END IF;
  
  IF v_actual_version = p_current_version THEN
    -- Update the transaction
    UPDATE transactions 
    SET 
      account_id = COALESCE(p_data->>'account_id', account_id),
      category_id = NULLIF(p_data->>'category_id', '')::UUID,
      amount = COALESCE((p_data->>'amount')::DECIMAL, amount),
      description = COALESCE(p_data->>'description', description),
      date = COALESCE((p_data->>'date')::DATE, date),
      is_reconciled = COALESCE((p_data->>'is_reconciled')::BOOLEAN, is_reconciled),
      updated_by = p_user_id,
      updated_at = NOW(),
      version = version + 1
    WHERE id = p_transaction_id;
    
    RETURN jsonb_build_object('success', TRUE, 'version', v_actual_version + 1);
  ELSE
    -- Version conflict
    RETURN jsonb_build_object(
      'success', FALSE, 
      'error', 'Version conflict', 
      'actual_version', v_actual_version,
      'provided_version', p_current_version
    );
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;