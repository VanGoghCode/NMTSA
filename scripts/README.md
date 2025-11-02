# Automation Scripts

This directory contains automation scripts for deployment, AWS operations, database management, and project setup.

## Structure

```
scripts/
├── aws/       # AWS automation scripts (S3, EC2, Lambda, CloudFormation)
├── deploy/    # Deployment scripts
├── db/        # Database migration and seed scripts
└── setup/     # Project setup and initialization scripts
```

## Usage

### PowerShell Scripts
```powershell
.\scripts\aws\deploy-s3.ps1
```

### Bash Scripts (WSL/Git Bash)
```bash
bash scripts/aws/deploy-s3.sh
```

## Best Practices

- Make scripts idempotent
- Add error handling and logging
- Use environment variables for configuration
- Document required permissions and prerequisites
- Version control all scripts
