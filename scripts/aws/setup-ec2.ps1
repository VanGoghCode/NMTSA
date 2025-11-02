# AWS EC2 Setup Script (PowerShell)
# This script creates and configures an EC2 instance for the application

param(
    [Parameter(Mandatory=$false)]
    [string]$InstanceType = "t2.micro",
    
    [Parameter(Mandatory=$false)]
    [string]$Region = $env:AWS_REGION,
    
    [Parameter(Mandatory=$false)]
    [string]$KeyName = "nmtsa-key",
    
    [Parameter(Mandatory=$false)]
    [string]$SecurityGroup = "nmtsa-sg"
)

if (-not $Region) {
    $Region = "us-east-1"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "AWS EC2 Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Instance Type: $InstanceType" -ForegroundColor Yellow
Write-Host "Region: $Region" -ForegroundColor Yellow
Write-Host "Key Name: $KeyName" -ForegroundColor Yellow
Write-Host ""

# Check AWS CLI
try {
    aws --version | Out-Null
} catch {
    Write-Error "AWS CLI is not installed"
    exit 1
}

# Get latest Amazon Linux 2023 AMI
Write-Host "Getting latest Amazon Linux 2023 AMI..." -ForegroundColor Green
$AMI_ID = aws ec2 describe-images `
    --owners amazon `
    --filters "Name=name,Values=al2023-ami-*-x86_64" `
    --query 'sort_by(Images, &CreationDate)[-1].ImageId' `
    --output text `
    --region $Region

Write-Host "AMI ID: $AMI_ID" -ForegroundColor Yellow

# Create security group if it doesn't exist
Write-Host "Checking security group..." -ForegroundColor Green
$SG_EXISTS = aws ec2 describe-security-groups `
    --group-names $SecurityGroup `
    --region $Region `
    2>$null

if (-not $SG_EXISTS) {
    Write-Host "Creating security group..." -ForegroundColor Green
    aws ec2 create-security-group `
        --group-name $SecurityGroup `
        --description "Security group for NMTSA application" `
        --region $Region
    
    # Add rules
    aws ec2 authorize-security-group-ingress `
        --group-name $SecurityGroup `
        --protocol tcp --port 22 --cidr 0.0.0.0/0 `
        --region $Region
    
    aws ec2 authorize-security-group-ingress `
        --group-name $SecurityGroup `
        --protocol tcp --port 80 --cidr 0.0.0.0/0 `
        --region $Region
    
    aws ec2 authorize-security-group-ingress `
        --group-name $SecurityGroup `
        --protocol tcp --port 443 --cidr 0.0.0.0/0 `
        --region $Region
}

# Launch EC2 instance
Write-Host "Launching EC2 instance..." -ForegroundColor Green
$INSTANCE_ID = aws ec2 run-instances `
    --image-id $AMI_ID `
    --instance-type $InstanceType `
    --key-name $KeyName `
    --security-groups $SecurityGroup `
    --region $Region `
    --query 'Instances[0].InstanceId' `
    --output text

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "EC2 Instance Created!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Instance ID: $INSTANCE_ID" -ForegroundColor Cyan
Write-Host ""
Write-Host "Waiting for instance to be running..." -ForegroundColor Yellow
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $Region

$PUBLIC_IP = aws ec2 describe-instances `
    --instance-ids $INSTANCE_ID `
    --region $Region `
    --query 'Reservations[0].Instances[0].PublicIpAddress' `
    --output text

Write-Host "Public IP: $PUBLIC_IP" -ForegroundColor Cyan
Write-Host ""
Write-Host "Connect to your instance:" -ForegroundColor Yellow
Write-Host "ssh -i $KeyName.pem ec2-user@$PUBLIC_IP" -ForegroundColor Cyan
