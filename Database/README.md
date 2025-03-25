# Database Documentation

This directory contains SQL scripts documenting the Supabase database structure that has already been implemented.

## Directory Structure

- **schema/**: Database schema definition
  - `tables.sql`: All database tables with their columns and constraints

- **functions/**: Database functions
  - `update_transaction_with_version.sql`: Function for handling transaction versioning and conflicts
  - `check_user_limit.sql`: Function to limit the number of users

- **policies/**: Row Level Security (RLS) policies
  - `row_level_security.sql`: All RLS policies for database tables

## Purpose

These files serve as documentation of the database structure that has already been implemented in Supabase. They can be used for:

1. Understanding the database schema
2. Reference for future modifications
3. Recreating the database if needed
4. Onboarding new team members

Note: These files reflect the current state of the database and are not intended to be run as migrations.
