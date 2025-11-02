# Install Dependencies Script (PowerShell)
# This script installs all required dependencies for the project

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Project Dependencies" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Node.js
Write-Host "Checking Node.js installation..." -ForegroundColor Green
try {
    $nodeVersion = node --version
    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Yellow
} catch {
    Write-Error "Node.js is not installed. Please install from https://nodejs.org/"
    exit 1
}

# Check npm
Write-Host "Checking npm installation..." -ForegroundColor Green
try {
    $npmVersion = npm --version
    Write-Host "npm version: $npmVersion" -ForegroundColor Yellow
} catch {
    Write-Error "npm is not installed"
    exit 1
}

# Install npm dependencies
Write-Host ""
Write-Host "Installing npm dependencies..." -ForegroundColor Green
npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Dependencies installed successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Copy .env.example to .env and configure" -ForegroundColor Cyan
    Write-Host "2. Run 'npm run dev' to start development server" -ForegroundColor Cyan
} else {
    Write-Error "Failed to install dependencies"
    exit 1
}
