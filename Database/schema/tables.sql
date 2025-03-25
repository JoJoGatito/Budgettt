-- Accounts Table
CREATE TABLE accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  name TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('bank', 'credit_card', 'loan')),
  balance DECIMAL NOT NULL,
  include_in_budget BOOLEAN NOT NULL DEFAULT TRUE,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  last_reconciled_at TIMESTAMP WITH TIME ZONE,
  external_id TEXT,
  connection_id TEXT,
  connection_details JSONB,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Categories Table
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  parent_id UUID,
  color TEXT,
  icon TEXT,
  is_system BOOLEAN NOT NULL DEFAULT FALSE,
  created_by UUID NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Import Batches Table (for future SimpleFIN integration)
CREATE TABLE import_batches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL,
  started_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'failed')),
  error_details TEXT,
  total_transactions INTEGER,
  created_by UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Transactions Table
CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL,
  category_id UUID,
  amount DECIMAL NOT NULL,
  description TEXT NOT NULL,
  date DATE NOT NULL,
  is_reconciled BOOLEAN NOT NULL DEFAULT FALSE,
  entry_method TEXT NOT NULL DEFAULT 'manual' CHECK (entry_method IN ('manual', 'imported', 'recurring')),
  external_id TEXT,
  import_batch_id UUID,
  checksum TEXT,
  metadata JSONB,
  created_by UUID NOT NULL,
  updated_by UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  version INTEGER NOT NULL DEFAULT 1
);

-- Goals Table
CREATE TABLE goals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  target_amount DECIMAL NOT NULL,
  current_amount DECIMAL NOT NULL DEFAULT 0,
  start_date DATE NOT NULL,
  target_date DATE,
  category_id UUID,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  priority INTEGER NOT NULL DEFAULT 0,
  created_by UUID NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Goal Allocations Table
CREATE TABLE goal_allocations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  goal_id UUID NOT NULL,
  amount DECIMAL NOT NULL,
  date DATE NOT NULL,
  notes TEXT,
  transaction_id UUID,
  created_by UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Categorization Rules Table (for future SimpleFIN integration)
CREATE TABLE categorization_rules (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  category_id UUID NOT NULL,
  match_description TEXT,
  match_amount_min DECIMAL,
  match_amount_max DECIMAL,
  match_payee TEXT,
  priority INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_by UUID NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Recurring Transactions Table (for future SimpleFIN integration)
CREATE TABLE recurring_transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL,
  category_id UUID,
  amount DECIMAL NOT NULL,
  description TEXT NOT NULL,
  frequency TEXT NOT NULL CHECK (frequency IN ('daily', 'weekly', 'monthly', 'yearly')),
  start_date DATE NOT NULL,
  end_date DATE,
  last_occurrence DATE,
  next_occurrence DATE,
  match_description TEXT[],
  match_amount_variance DECIMAL,
  match_payee TEXT,
  auto_categorize BOOLEAN NOT NULL DEFAULT TRUE,
  created_by UUID NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Accounts Table
ALTER TABLE accounts 
  ADD CONSTRAINT fk_accounts_user
  FOREIGN KEY (user_id) 
  REFERENCES auth.users(id);

-- Categories Table
ALTER TABLE categories 
  ADD CONSTRAINT fk_categories_parent
  FOREIGN KEY (parent_id) 
  REFERENCES categories(id);

ALTER TABLE categories 
  ADD CONSTRAINT fk_categories_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

-- Import Batches Table
ALTER TABLE import_batches 
  ADD CONSTRAINT fk_import_batches_account
  FOREIGN KEY (account_id) 
  REFERENCES accounts(id);

ALTER TABLE import_batches 
  ADD CONSTRAINT fk_import_batches_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

-- Transactions Table
ALTER TABLE transactions 
  ADD CONSTRAINT fk_transactions_account
  FOREIGN KEY (account_id) 
  REFERENCES accounts(id);

ALTER TABLE transactions 
  ADD CONSTRAINT fk_transactions_category
  FOREIGN KEY (category_id) 
  REFERENCES categories(id);

ALTER TABLE transactions 
  ADD CONSTRAINT fk_transactions_import_batch
  FOREIGN KEY (import_batch_id) 
  REFERENCES import_batches(id);

ALTER TABLE transactions 
  ADD CONSTRAINT fk_transactions_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

ALTER TABLE transactions 
  ADD CONSTRAINT fk_transactions_updated_by
  FOREIGN KEY (updated_by) 
  REFERENCES auth.users(id);

-- Goals Table
ALTER TABLE goals 
  ADD CONSTRAINT fk_goals_category
  FOREIGN KEY (category_id) 
  REFERENCES categories(id);

ALTER TABLE goals 
  ADD CONSTRAINT fk_goals_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

-- Goal Allocations Table
ALTER TABLE goal_allocations 
  ADD CONSTRAINT fk_goal_allocations_goal
  FOREIGN KEY (goal_id) 
  REFERENCES goals(id);

ALTER TABLE goal_allocations 
  ADD CONSTRAINT fk_goal_allocations_transaction
  FOREIGN KEY (transaction_id) 
  REFERENCES transactions(id);

ALTER TABLE goal_allocations 
  ADD CONSTRAINT fk_goal_allocations_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

-- Categorization Rules Table
ALTER TABLE categorization_rules 
  ADD CONSTRAINT fk_categorization_rules_category
  FOREIGN KEY (category_id) 
  REFERENCES categories(id);

ALTER TABLE categorization_rules 
  ADD CONSTRAINT fk_categorization_rules_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);

-- Recurring Transactions Table
ALTER TABLE recurring_transactions 
  ADD CONSTRAINT fk_recurring_transactions_account
  FOREIGN KEY (account_id) 
  REFERENCES accounts(id);

ALTER TABLE recurring_transactions 
  ADD CONSTRAINT fk_recurring_transactions_category
  FOREIGN KEY (category_id) 
  REFERENCES categories(id);

ALTER TABLE recurring_transactions 
  ADD CONSTRAINT fk_recurring_transactions_created_by
  FOREIGN KEY (created_by) 
  REFERENCES auth.users(id);