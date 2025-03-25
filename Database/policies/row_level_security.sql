-- Enable Row-Level Security on all tables
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_allocations ENABLE ROW LEVEL SECURITY;
ALTER TABLE import_batches ENABLE ROW LEVEL SECURITY;
ALTER TABLE categorization_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE recurring_transactions ENABLE ROW LEVEL SECURITY;

-- Create policies for each table

-- Accounts policies
CREATE POLICY "Users can view their own accounts"
ON accounts FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own accounts"
ON accounts FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own accounts"
ON accounts FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY "Users can delete their own accounts"
ON accounts FOR DELETE
USING (user_id = auth.uid());

-- Transactions policies (with multi-user access based on account ownership)
CREATE POLICY "Users can view transactions from their accounts"
ON transactions FOR SELECT
USING (account_id IN (SELECT id FROM accounts WHERE user_id = auth.uid()));

CREATE POLICY "Users can insert transactions to their accounts"
ON transactions FOR INSERT
WITH CHECK (
  account_id IN (SELECT id FROM accounts WHERE user_id = auth.uid())
  AND created_by = auth.uid()
  AND updated_by = auth.uid()
);

CREATE POLICY "Users can update transactions from their accounts"
ON transactions FOR UPDATE
USING (
  account_id IN (SELECT id FROM accounts WHERE user_id = auth.uid())
)
WITH CHECK (
  updated_by = auth.uid()
);

CREATE POLICY "Users can delete transactions from their accounts"
ON transactions FOR DELETE
USING (account_id IN (SELECT id FROM accounts WHERE user_id = auth.uid()));

-- Categories policies (shared between users)
CREATE POLICY "All users can view categories"
ON categories FOR SELECT
USING (TRUE);

CREATE POLICY "Users can insert their own categories"
ON categories FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own categories"
ON categories FOR UPDATE
USING (created_by = auth.uid() OR is_system = FALSE);

CREATE POLICY "Users can delete their own non-system categories"
ON categories FOR DELETE
USING (created_by = auth.uid() AND is_system = FALSE);

-- Goals policies
CREATE POLICY "Users can view their own goals"
ON goals FOR SELECT
USING (created_by = auth.uid());

CREATE POLICY "Users can insert their own goals"
ON goals FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own goals"
ON goals FOR UPDATE
USING (created_by = auth.uid());

CREATE POLICY "Users can delete their own goals"
ON goals FOR DELETE
USING (created_by = auth.uid());

-- Goal Allocations policies
CREATE POLICY "Users can view their own goal allocations"
ON goal_allocations FOR SELECT
USING (created_by = auth.uid() OR goal_id IN (SELECT id FROM goals WHERE created_by = auth.uid()));

CREATE POLICY "Users can insert their own goal allocations"
ON goal_allocations FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own goal allocations"
ON goal_allocations FOR UPDATE
USING (created_by = auth.uid());

CREATE POLICY "Users can delete their own goal allocations"
ON goal_allocations FOR DELETE
USING (created_by = auth.uid());

-- Import Batches policies
CREATE POLICY "Users can view their own import batches"
ON import_batches FOR SELECT
USING (created_by = auth.uid());

CREATE POLICY "Users can insert their own import batches"
ON import_batches FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own import batches"
ON import_batches FOR UPDATE
USING (created_by = auth.uid());

CREATE POLICY "Users can delete their own import batches"
ON import_batches FOR DELETE
USING (created_by = auth.uid());

-- Categorization Rules policies
CREATE POLICY "Users can view their own categorization rules"
ON categorization_rules FOR SELECT
USING (created_by = auth.uid());

CREATE POLICY "Users can insert their own categorization rules"
ON categorization_rules FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own categorization rules"
ON categorization_rules FOR UPDATE
USING (created_by = auth.uid());

CREATE POLICY "Users can delete their own categorization rules"
ON categorization_rules FOR DELETE
USING (created_by = auth.uid());

-- Recurring Transactions policies
CREATE POLICY "Users can view their own recurring transactions"
ON recurring_transactions FOR SELECT
USING (created_by = auth.uid());

CREATE POLICY "Users can insert their own recurring transactions"
ON recurring_transactions FOR INSERT
WITH CHECK (created_by = auth.uid());

CREATE POLICY "Users can update their own recurring transactions"
ON recurring_transactions FOR UPDATE
USING (created_by = auth.uid());

CREATE POLICY "Users can delete their own recurring transactions"
ON recurring_transactions FOR DELETE
USING (created_by = auth.uid());