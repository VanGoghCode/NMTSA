/**
 * Frontend Configuration
 * Environment-based configuration for the frontend application
 */

export const config = {
  app: {
    name: process.env.NEXT_PUBLIC_APP_NAME || 'NMTSA',
    env: process.env.NODE_ENV || 'development',
  },
  api: {
    baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api',
    timeout: 30000,
  },
  aws: {
    region: process.env.NEXT_PUBLIC_AWS_REGION || 'us-east-1',
    s3Bucket: process.env.NEXT_PUBLIC_S3_BUCKET || '',
  },
  features: {
    enableAnalytics: process.env.NEXT_PUBLIC_ENABLE_ANALYTICS === 'true',
    enableLogging: process.env.NEXT_PUBLIC_ENABLE_LOGGING === 'true',
  },
} as const;

export default config;
