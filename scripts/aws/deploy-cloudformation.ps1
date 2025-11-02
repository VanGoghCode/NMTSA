# Deploy CloudFormation Stack (PowerShell)
# This script deploys the infrastructure using AWS CloudFormation

param(
    [Parameter(Mandatory=$true)]
    [string]$StackName,
    
    [Parameter(Mandatory=$true)]
    [string]$S3BucketName,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('development', 'staging', 'production')]
    [string]$Environment = 'development',
    
    [Parameter(Mandatory=$false)]
    [string]$Region = $env:AWS_REGION
)

if (-not $Region) {
    $Region = "us-east-1"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "AWS CloudFormation Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Stack Name: $StackName" -ForegroundColor Yellow
Write-Host "Environment: $Environment" -ForegroundColor Yellow
Write-Host "S3 Bucket: $S3BucketName" -ForegroundColor Yellow
Write-Host "Region: $Region" -ForegroundColor Yellow
Write-Host ""

# Check if AWS CLI is installed
try {
    aws --version | Out-Null
} catch {
    Write-Error "AWS CLI is not installed"
    exit 1
}

# Validate CloudFormation template
Write-Host "Validating CloudFormation template..." -ForegroundColor Green
aws cloudformation validate-template `
    --template-body file://.aws/cloudformation-template.yaml `
    --region $Region

if ($LASTEXITCODE -ne 0) {
    Write-Error "Template validation failed"
    exit 1
}

# Check if stack exists
Write-Host "Checking if stack exists..." -ForegroundColor Green
$stackExists = aws cloudformation describe-stacks `
    --stack-name $StackName `
    --region $Region `
    2>$null

if ($stackExists) {
    # Update existing stack
    Write-Host "Updating existing stack..." -ForegroundColor Green
    aws cloudformation update-stack `
        --stack-name $StackName `
        --template-body file://.aws/cloudformation-template.yaml `
        --parameters `
            ParameterKey=EnvironmentName,ParameterValue=$Environment `
            ParameterKey=S3BucketName,ParameterValue=$S3BucketName `
        --capabilities CAPABILITY_IAM `
        --region $Region
    
    $operation = "update"
} else {
    # Create new stack
    Write-Host "Creating new stack..." -ForegroundColor Green
    aws cloudformation create-stack `
        --stack-name $StackName `
        --template-body file://.aws/cloudformation-template.yaml `
        --parameters `
            ParameterKey=EnvironmentName,ParameterValue=$Environment `
            ParameterKey=S3BucketName,ParameterValue=$S3BucketName `
        --capabilities CAPABILITY_IAM `
        --region $Region
    
    $operation = "create"
}

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Waiting for stack $operation to complete..." -ForegroundColor Yellow
    
    if ($operation -eq "create") {
        aws cloudformation wait stack-create-complete `
            --stack-name $StackName `
            --region $Region
    } else {
        aws cloudformation wait stack-update-complete `
            --stack-name $StackName `
            --region $Region
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "Stack $operation completed successfully!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        
        # Get stack outputs
        Write-Host ""
        Write-Host "Stack Outputs:" -ForegroundColor Yellow
        aws cloudformation describe-stacks `
            --stack-name $StackName `
            --region $Region `
            --query 'Stacks[0].Outputs' `
            --output table
    } else {
        Write-Error "Stack $operation failed"
        exit 1
    }
} else {
    Write-Error "Failed to initiate stack $operation"
    exit 1
}
