# AWS S3 Deployment Script (PowerShell)
# This script deploys static assets to AWS S3

param(
    [Parameter(Mandatory=$false)]
    [string]$BucketName = $env:AWS_S3_BUCKET,
    
    [Parameter(Mandatory=$false)]
    [string]$Region = $env:AWS_REGION,
    
    [Parameter(Mandatory=$false)]
    [string]$SourceDir = ".\out"
)

# Configuration
if (-not $BucketName) {
    Write-Error "S3 Bucket name is required. Set AWS_S3_BUCKET environment variable or pass -BucketName parameter"
    exit 1
}

if (-not $Region) {
    $Region = "us-east-1"
    Write-Warning "AWS Region not specified. Using default: $Region"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "AWS S3 Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Bucket: $BucketName" -ForegroundColor Yellow
Write-Host "Region: $Region" -ForegroundColor Yellow
Write-Host "Source: $SourceDir" -ForegroundColor Yellow
Write-Host ""

# Check if AWS CLI is installed
try {
    aws --version | Out-Null
} catch {
    Write-Error "AWS CLI is not installed. Please install it from https://aws.amazon.com/cli/"
    exit 1
}

# Check if source directory exists
if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory '$SourceDir' does not exist"
    exit 1
}

# Build the Next.js application
Write-Host "Building Next.js application..." -ForegroundColor Green
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed"
    exit 1
}

# Sync files to S3
Write-Host "Uploading files to S3..." -ForegroundColor Green
aws s3 sync $SourceDir s3://$BucketName --region $Region --delete

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Deployment successful!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Your application is now available at:" -ForegroundColor Yellow
    Write-Host "https://$BucketName.s3.$Region.amazonaws.com" -ForegroundColor Cyan
} else {
    Write-Error "Deployment failed"
    exit 1
}
