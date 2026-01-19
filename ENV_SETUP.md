# Environment Variables Setup

This file contains your environment variables for the LACRP Forums application.

## Required Environment Variables

Create a `.env.local` file in the root directory with the following variables:

```env
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://dgulbgnksglcvuubdwwd.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRndWxiZ25rc2dsY3Z1dWJkd3dkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3NTIxOTgsImV4cCI6MjA4NDMyODE5OH0.sLVWXYgC8kltfL6lggETk6Q_8tablekI88aealaDSiE
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRndWxiZ25rc2dsY3Z1dWJkd3dkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODc1MjE5OCwiZXhwIjoyMDg0MzI4MTk4fQ.UjoDYaFdqrNBsf36FVVHgDr_HA7vHDXzzRT44Rx0BdI

# Discord OAuth Configuration
DISCORD_CLIENT_ID=1462489272253943963
DISCORD_CLIENT_SECRET=uLZCfiYSm-c-y8ykO8kLxc1DvC57j6zM
NEXT_PUBLIC_DISCORD_REDIRECT_URI=http://localhost:3000/api/auth/callback/discord

# Discord Webhook (for application notifications)
# Webhook for sending application submissions to Discord
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/1462601081249992735/MMECsJTs9kpiNkSh_zkWsLnTfQVvh5MWGI5T8D0LJDBc47DgTwdNBBBDUfkMa1hjQiXu
```

## Important Notes

⚠️ **SECURITY WARNING**: 
- The `.env.local` file is already in `.gitignore` and will NOT be committed to git
- Never share your `SUPABASE_SERVICE_ROLE_KEY` publicly
- Never commit `.env.local` to version control
- The service role key has admin access to your Supabase database

## What Each Variable Does

- **NEXT_PUBLIC_SUPABASE_URL**: Your Supabase project URL (publicly accessible)
- **NEXT_PUBLIC_SUPABASE_ANON_KEY**: Public anonymous key for client-side Supabase operations
- **SUPABASE_SERVICE_ROLE_KEY**: Service role key for server-side admin operations (keep secret!)
- **DISCORD_CLIENT_ID**: Your Discord application client ID
- **DISCORD_CLIENT_SECRET**: Your Discord application client secret (keep secret!)
- **NEXT_PUBLIC_DISCORD_REDIRECT_URI**: The callback URL for Discord OAuth
- **DISCORD_WEBHOOK_URL**: Webhook URL for sending application notifications to Discord

## Next Steps

1. Copy the template above into a `.env.local` file
2. Replace `DISCORD_WEBHOOK_URL` with your actual Discord webhook URL
3. For production, update `NEXT_PUBLIC_DISCORD_REDIRECT_URI` to your production URL
4. Run `npm run dev` to start the development server
