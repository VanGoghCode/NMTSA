# Deployment Guide

## Prerequisites

- Node.js 20.9.0+ installed (required for Next.js)
- AWS CLI configured with credentials
- AWS account with appropriate permissions
- Git repository access

## Environment Setup

1. **Copy environment template**
   ```powershell
   Copy-Item .env.example .env
   ```

2. **Configure environment variables**
   Edit `.env` file with your actual values:
   - Database credentials
   - AWS credentials
   - JWT secret
   - API endpoints

## Local Development

```powershell
# Install dependencies
npm install

# Run development server
npm run dev
```

Visit `http://localhost:3000`

## Building for Production

```powershell
# Build the application
npm run build

# Test production build locally
npm run start
```

## Deployment Options

### AWS Amplify Hosting (Recommended)

Amplify Hosting provides CI/CD, preview builds, custom domains, and supports Next.js (static and SSR) out of the box.

1. **Prepare the repo**
   - Ensure `amplify.yml` exists in the repo root (provided in this repo) to define build steps.
   - Optional: `.nvmrc` set to `20` to match Amplify's Node runtime.

2. **Create an Amplify app (Console)**
   - Go to AWS Console → Amplify Hosting → Get started.
   - Connect your GitHub repository and select the `main` and/or `develop` branches.
   - Amplify will detect Next.js and create a build pipeline.

3. **Configure environment variables**
   - In Amplify → App settings → Environment variables, add any `NEXT_PUBLIC_*` and server-side vars your app needs.
   - Re-deploy after saving.

4. **Domains and redirects**
   - Add a custom domain in Amplify → Domain management.
   - Amplify auto-configures HTTPS. Add any redirects/rewrites as needed.

5. **PR previews (optional)**
   - Enable "Preview builds" so pull requests get a unique preview URL per branch.

**Notes:**
- For purely static sites, Amplify deploys the `./.next` artifacts. For SSR/ISR, Amplify manages server output automatically.
- This repo deploys via Amplify Hosting; previous S3/CloudFront steps have been removed.

## Automated Deployment

Use the deployment script for streamlined deployments:

```powershell
# Deploy to staging
.\scripts\deploy\deploy.ps1 -Environment staging

# Deploy to production (with confirmation)
.\scripts\deploy\deploy.ps1 -Environment production
```

## Environment-Specific Deployments

### Development
- Automatic deployments on push to `develop` branch
- Debug logging enabled
- Source maps included

### Staging
- Manual or automated deployment from `staging` branch
- Production-like environment for testing
- Limited logging

### Production
- Manual deployment from `main` branch
- Optimized build
- Error tracking enabled
- No debug information

## Post-Deployment

1. **Verify deployment**
   - Check application is accessible
   - Test critical user flows
   - Review logs for errors

2. **Monitor**
   - Set up CloudWatch alarms
   - Monitor error rates
   - Track performance metrics

3. **Rollback (if needed)**
   ```powershell
   # Rollback to previous version
   git revert HEAD
   .\scripts\deploy\deploy.ps1
   ```

## Troubleshooting

### Build Failures
- Check Node.js version compatibility
- Verify all environment variables are set
- Review build logs for errors

### Deployment Failures
- Verify Amplify build logs
- Ensure Amplify environment variables are set
- Check custom domain configuration

### Runtime Errors
- Check CloudWatch logs
- Verify database connectivity
- Review environment configuration

## Security Checklist

- [ ] All sensitive data in environment variables
- [ ] `.env` files not committed to git
- [ ] AWS credentials rotated regularly
- [ ] HTTPS enabled
- [ ] CORS properly configured
- [ ] Security headers set
- [ ] Dependencies updated

## CI/CD Pipeline (Future)

Consider setting up automated CI/CD with:
- GitHub Actions
- AWS CodePipeline
- Jenkins
- GitLab CI/CD
