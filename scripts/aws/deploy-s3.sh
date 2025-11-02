#!/bin/bash

# AWS S3 Deployment Script (Bash)
# This script deploys static assets to AWS S3

set -e

# Configuration
BUCKET_NAME="${AWS_S3_BUCKET:-}"
REGION="${AWS_REGION:-us-east-1}"
SOURCE_DIR="${1:-./out}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}AWS S3 Deployment Script${NC}"
echo -e "${CYAN}========================================${NC}"

# Validate inputs
if [ -z "$BUCKET_NAME" ]; then
    echo -e "${RED}Error: S3 Bucket name is required${NC}"
    echo "Set AWS_S3_BUCKET environment variable or pass as argument"
    exit 1
fi

echo -e "${YELLOW}Bucket: $BUCKET_NAME${NC}"
echo -e "${YELLOW}Region: $REGION${NC}"
echo -e "${YELLOW}Source: $SOURCE_DIR${NC}"
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}Error: AWS CLI is not installed${NC}"
    echo "Please install it from https://aws.amazon.com/cli/"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory '$SOURCE_DIR' does not exist${NC}"
    exit 1
fi

# Build the Next.js application
echo -e "${GREEN}Building Next.js application...${NC}"
npm run build

# Sync files to S3
echo -e "${GREEN}Uploading files to S3...${NC}"
aws s3 sync "$SOURCE_DIR" "s3://$BUCKET_NAME" --region "$REGION" --delete

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Deployment successful!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${YELLOW}Your application is now available at:${NC}"
echo -e "${CYAN}https://$BUCKET_NAME.s3.$REGION.amazonaws.com${NC}"
