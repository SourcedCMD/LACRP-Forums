-- =============================================
-- LACRP Forums - Complete Database Schema
-- Los Angeles County Roleplay Forums
-- =============================================
-- This script creates the complete database structure
-- for the LACRP Forums application.
-- 
-- Instructions:
--   1. Open Supabase SQL Editor
--   2. Copy this entire script
--   3. Paste and click "Run"
-- =============================================

-- =============================================
-- 1. USERS TABLE
-- Stores Discord OAuth user information
-- =============================================
CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  discord_id VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  avatar TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- 2. APPLICATIONS TABLE
-- Stores department and staff job applications
-- =============================================
CREATE TABLE IF NOT EXISTS applications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  department_id VARCHAR(255) NOT NULL,
  department_name VARCHAR(255) NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  user_email VARCHAR(255) NOT NULL,
  username VARCHAR(255) NOT NULL,
  age INTEGER NOT NULL,
  experience TEXT NOT NULL,
  why_join TEXT NOT NULL,
  what_can_you_bring TEXT NOT NULL,
  availability TEXT NOT NULL,
  previous_experience TEXT,
  submitted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  status VARCHAR(50) DEFAULT 'pending',
  reviewed_by VARCHAR(255),
  reviewed_at TIMESTAMP WITH TIME ZONE,
  notes TEXT
);

-- =============================================
-- 3. INDEXES
-- Improve query performance
-- =============================================

-- Users table indexes
CREATE INDEX IF NOT EXISTS idx_users_discord_id ON users(discord_id);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);

-- Applications table indexes
CREATE INDEX IF NOT EXISTS idx_applications_user_id ON applications(user_id);
CREATE INDEX IF NOT EXISTS idx_applications_department_id ON applications(department_id);
CREATE INDEX IF NOT EXISTS idx_applications_status ON applications(status);
CREATE INDEX IF NOT EXISTS idx_applications_submitted_at ON applications(submitted_at DESC);
CREATE INDEX IF NOT EXISTS idx_applications_user_department ON applications(user_id, department_id);

-- =============================================
-- 4. FUNCTIONS & TRIGGERS
-- Auto-update updated_at timestamp
-- =============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for users table
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =============================================
-- 5. ROW LEVEL SECURITY (RLS)
-- Enabled but bypassed by service role key
-- =============================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;

-- Note: The application uses SUPABASE_SERVICE_ROLE_KEY which bypasses RLS.
-- These policies are for future use if switching to user-level access.

-- =============================================
-- 6. VERIFICATION
-- Check that everything was created successfully
-- =============================================

-- Verify tables exist
SELECT 
    'Tables Created' as check_type,
    COUNT(*) as count
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('users', 'applications');

-- Verify columns in applications table
SELECT 
    'Applications Columns' as check_type,
    COUNT(*) as column_count
FROM information_schema.columns 
WHERE table_name = 'applications';

-- List all columns in applications table
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'applications' 
ORDER BY ordinal_position;

-- =============================================
-- SCHEMA SETUP COMPLETE!
-- =============================================
-- Your database is ready for the LACRP Forums application.
-- 
-- Tables created:
--   ✓ users - Stores Discord user information
--   ✓ applications - Stores department/staff applications
--
-- The application will automatically:
--   - Create users when they sign in with Discord
--   - Save applications when submitted
--   - Send notifications to Discord webhook
-- =============================================
