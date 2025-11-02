# Main Deployment Script (PowerShell)
# This script orchestrates the deployment process

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('development', 'staging', 'production')]
    [string]$Environment = 'development',
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipBuild = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipTests = $false
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NMTSA Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Environment: $Environment" -ForegroundColor Yellow
Write-Host "Timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Yellow
Write-Host ""

# Load environment variables
if (Test-Path ".env.$Environment") {
    Write-Host "Loading environment variables..." -ForegroundColor Green
    Get-Content ".env.$Environment" | ForEach-Object {
        if ($_ -match '^([^=]+)=(.*)$') {
            [Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
        }
    }
}

# Run tests
if (-not $SkipTests) {
    Write-Host "Running tests..." -ForegroundColor Green
    npm test
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Tests failed. Deployment aborted."
        exit 1
    }
}

# Build application
if (-not $SkipBuild) {
    Write-Host "Building application..." -ForegroundColor Green
    npm run build
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Build failed. Deployment aborted."
        exit 1
    }
}

# Deploy based on environment
switch ($Environment) {
    'development' {
        Write-Host "Deploying to development..." -ForegroundColor Green
        # Add development deployment logic
    }
    'staging' {
        Write-Host "Deploying to staging..." -ForegroundColor Green
        # Add staging deployment logic
    }
    'production' {
        Write-Host "Deploying to production..." -ForegroundColor Green
        # Confirm production deployment
        $confirm = Read-Host "Are you sure you want to deploy to PRODUCTION? (yes/no)"
        if ($confirm -ne "yes") {
            Write-Host "Deployment cancelled." -ForegroundColor Yellow
            exit 0
        }
        # Add production deployment logic
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Deployment Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Environment: $Environment" -ForegroundColor Cyan
Write-Host "Completed: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
