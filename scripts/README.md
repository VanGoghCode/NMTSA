# Automation Scripts

This directory contains automation scripts for deployment, AWS operations, database management, and project setup.

## Structure

```
scripts/
├── deploy/    # Deployment scripts
├── db/        # Database migration and seed scripts
└── setup/     # Project setup and initialization scripts
```

## Usage

### Deployment
Website deployments are handled by AWS Amplify Hosting. No manual S3 upload is required.

### PowerShell Scripts
```powershell
# Example: Run deployment script
./scripts/deploy/deploy.ps1 -Environment production
```

### Bash Scripts (WSL/Git Bash)
```bash
# Deployments are handled by AWS Amplify Hosting
echo "Push to main branch to trigger Amplify deployment"
```

## Best Practices

- Make scripts idempotent
- Add error handling and logging
- Use environment variables for configuration
- Document required permissions and prerequisites
- Version control all scripts
