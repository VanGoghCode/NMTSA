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

### Option 1: AWS S3 + CloudFront (Static Export)

1. **Configure Next.js for static export** (if needed)
2. **Build and export**
   ```powershell
   npm run build
   ```
3. **Deploy to S3**
   ```powershell
   .\scripts\aws\deploy-s3.ps1 -BucketName your-bucket-name
   ```

### Option 2: AWS EC2 (Server-Side Rendering)

1. **Setup EC2 instance**
   ```powershell
   .\scripts\aws\setup-ec2.ps1 -InstanceType t2.small
   ```

2. **SSH into instance**
   ```bash
   ssh -i your-key.pem ec2-user@your-instance-ip
   ```

3. **Deploy application**
   ```bash
   git clone your-repo-url
   cd nmtsa
   npm install
   npm run build
   npm run start
   ```

### Option 3: Vercel (Recommended for Next.js)

1. **Install Vercel CLI**
   ```powershell
   npm i -g vercel
   ```

2. **Deploy**
   ```powershell
   vercel
   ```

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
- Verify AWS credentials
- Check S3 bucket permissions
- Ensure security groups allow traffic

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
