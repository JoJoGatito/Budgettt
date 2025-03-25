// Database types based on the schema
export interface User {
    id: string;
    email: string;
    created_at: string;
  }
  
  export interface Account {
    id: string;
    user_id: string;
    name: string;
    type: 'bank' | 'credit_card' | 'loan';
    balance: number;
    include_in_budget: boolean;
    is_active: boolean;
    last_reconciled_at: string | null;
    external_id: string | null;
    connection_id: string | null;
    connection_details: any | null;
    created_at: string;
    updated_at: string;
  }
  
  export interface Transaction {
    id: string;
    account_id: string;
    category_id: string | null;
    amount: number;
    description: string;
    date: string;
    is_reconciled: boolean;
    entry_method: 'manual' | 'imported' | 'recurring';
    external_id: string | null;
    import_batch_id: string | null;
    checksum: string | null;
    metadata: any | null;
    created_by: string;
    updated_by: string;
    created_at: string;
    updated_at: string;
    version: number;
  }
  
  export interface Category {
    id: string;
    name: string;
    parent_id: string | null;
    color: string | null;
    icon: string | null;
    is_system: boolean;
    created_by: string;
    updated_at: string;
  }
  
  export interface Goal {
    id: string;
    name: string;
    target_amount: number;
    current_amount: number;
    start_date: string;
    target_date: string | null;
    category_id: string | null;
    is_active: boolean;
    priority: number;
    created_by: string;
    updated_at: string;
  }
  
  export interface GoalAllocation {
    id: string;
    goal_id: string;
    amount: number;
    date: string;
    notes: string | null;
    transaction_id: string | null;
    created_by: string;
    created_at: string;
  }