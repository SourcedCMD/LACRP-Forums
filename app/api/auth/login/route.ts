import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
  const redirectUri = process.env.NEXT_PUBLIC_DISCORD_REDIRECT_URI || 'http://localhost:3000/api/auth/callback/discord'
  
  // Discord OAuth URL
  const discordAuthUrl = new URL('https://discord.com/api/oauth2/authorize')
  discordAuthUrl.searchParams.set('client_id', process.env.DISCORD_CLIENT_ID!)
  discordAuthUrl.searchParams.set('redirect_uri', redirectUri)
  discordAuthUrl.searchParams.set('response_type', 'code')
  discordAuthUrl.searchParams.set('scope', 'identify email')

  return NextResponse.redirect(discordAuthUrl.toString())
}
