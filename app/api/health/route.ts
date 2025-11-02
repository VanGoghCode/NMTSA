/**
 * Example API Route - Health Check
 * GET /api/health
 */

import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  return NextResponse.json(
    {
      success: true,
      message: 'API is running',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV,
    },
    { status: 200 }
  );
}
