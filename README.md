# Budget Tracker Application

A personal budget tracking application with multi-user sync and offline capabilities.

## Project Structure

- **database/**: SQL scripts for Supabase setup
  - **migrations/**: Database schema migrations
  - **seeds/**: Seed data scripts
  - **functions/**: SQL functions for business logic
- **frontend/**: Vite React application (PWA)

## Setup Instructions

### Database Setup

1. Create a new Supabase project
2. Run the SQL scripts in the following order:
   - `database/migrations/01_initial_tables.sql`
   - `database/migrations/02_add_foreign_keys.sql`
   - `database/seeds/default_categories.sql` (after creating your first user)
   - `database/functions/update_transaction_with_version.sql`

### Frontend Setup

1. Navigate to the frontend directory: `cd frontend`
2. Install dependencies: `npm install`
3. Create a `.env` file with your Supabase credentials
4. Start the development server: `npm run dev`

## Features

- Multi-user synchronization
- Offline capabilities
- Transaction history and categorization
- Goal tracking
- Future SimpleFIN integration
