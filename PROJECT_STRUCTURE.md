# NMTSA Project Structure

## Overview

This document describes the complete folder structure and organization of the NMTSA project.

## Root Directory

```
nmtsa/
├── app/                    # Next.js App Router
├── src/                    # Frontend source code
├── server/                 # Backend server code
├── scripts/                # Automation scripts
├── tests/                  # Test files
├── docs/                   # Documentation
├── public/                 # Static assets
├── .aws/                   # AWS configuration
├── .next/                  # Next.js build output (gitignored)
├── node_modules/           # Dependencies (gitignored)
├── .env                    # Environment variables (gitignored)
├── .env.example            # Environment template
├── .gitignore             # Git ignore rules
├── eslint.config.mjs      # ESLint configuration
├── next.config.ts         # Next.js configuration
├── next-env.d.ts          # Next.js TypeScript declarations
├── package.json           # Project dependencies
├── postcss.config.mjs     # PostCSS configuration
├── tsconfig.json          # TypeScript configuration
└── README.md              # Project readme
```

## Frontend Structure (`src/`)

```
src/
├── components/
│   ├── common/             # Reusable components
│   │   ├── Button.tsx
│   │   ├── Input.tsx
│   │   ├── Modal.tsx
│   │   └── Card.tsx
│   ├── layout/             # Layout components
│   │   ├── Header.tsx
│   │   ├── Footer.tsx
│   │   ├── Sidebar.tsx
│   │   └── Navigation.tsx
│   └── ui/                 # UI-specific components
│       ├── DataTable.tsx
│       ├── Charts.tsx
│       └── Forms.tsx
├── hooks/                  # Custom React hooks
│   ├── useAuth.ts
│   ├── useApi.ts
│   └── useLocalStorage.ts
├── lib/                    # Core libraries
│   ├── api/                # API client
│   │   ├── client.ts
│   │   ├── endpoints.ts
│   │   └── interceptors.ts
│   ├── utils/              # Utility functions
│   │   ├── index.ts
│   │   ├── formatters.ts
│   │   └── validators.ts
│   └── validators/         # Validation schemas
│       └── schemas.ts
├── types/                  # TypeScript types
│   ├── index.ts
│   ├── api.ts
│   └── models.ts
├── styles/                 # Global styles
│   ├── globals.css
│   └── themes.css
├── config/                 # Frontend configuration
│   └── index.ts
├── services/               # Business logic services
│   ├── authService.ts
│   └── userService.ts
├── contexts/               # React contexts
│   ├── AuthContext.tsx
│   └── ThemeContext.tsx
└── store/                  # State management
    ├── index.ts
    └── slices/
```

## Backend Structure (`server/`)

```
server/
├── api/                    # API route handlers
│   ├── routes/
│   │   ├── auth.ts
│   │   ├── users.ts
│   │   └── health.ts
│   └── index.ts
├── middleware/             # Express middleware
│   ├── auth.ts
│   ├── errorHandler.ts
│   ├── validation.ts
│   └── rateLimiter.ts
├── controllers/            # Request controllers
│   ├── authController.ts
│   └── userController.ts
├── models/                 # Data models
│   ├── User.ts
│   └── Session.ts
├── services/               # Business logic
│   ├── authService.ts
│   ├── emailService.ts
│   └── storageService.ts
├── utils/                  # Server utilities
│   ├── logger.ts
│   ├── crypto.ts
│   └── response.ts
├── config/                 # Server configuration
│   ├── index.ts
│   ├── database.ts
│   └── aws.ts
└── db/                     # Database
    ├── connection.ts
    ├── migrations/
    └── seeds/
```

## Scripts Structure (`scripts/`)

```
scripts/
├── aws/                    # AWS automation
│   ├── deploy-s3.ps1      # S3 deployment (PowerShell)
│   ├── deploy-s3.sh       # S3 deployment (Bash)
│   ├── setup-ec2.ps1      # EC2 setup
│   ├── setup-cloudfront.ps1
│   └── backup-s3.ps1
├── deploy/                 # Deployment scripts
│   ├── deploy.ps1         # Main deployment
│   ├── rollback.ps1       # Rollback deployment
│   └── healthcheck.ps1    # Post-deployment checks
├── db/                     # Database scripts
│   ├── migrate.ps1        # Run migrations
│   ├── seed.ps1           # Seed database
│   └── backup.ps1         # Backup database
└── setup/                  # Setup scripts
    ├── install-dependencies.ps1
    ├── setup-dev-env.ps1
    └── generate-env.ps1
```

## Tests Structure (`tests/`)

```
tests/
├── unit/                   # Unit tests
│   ├── components/
│   ├── hooks/
│   ├── services/
│   └── utils/
├── integration/            # Integration tests
│   ├── api/
│   └── database/
└── e2e/                    # End-to-end tests
    ├── auth.spec.ts
    └── user-flow.spec.ts
```

## Documentation (`docs/`)

```
docs/
├── ARCHITECTURE.md         # Architecture overview
├── API.md                  # API documentation
├── DEPLOYMENT.md           # Deployment guide
├── CONTRIBUTING.md         # Contribution guidelines
└── CHANGELOG.md            # Version history
```

## Key Files

### Configuration Files

- **`.env.example`** - Environment variable template
- **`tsconfig.json`** - TypeScript compiler options
- **`next.config.ts`** - Next.js framework configuration
- **`eslint.config.mjs`** - Code linting rules
- **`postcss.config.mjs`** - PostCSS configuration

### Package Files

- **`package.json`** - Dependencies and scripts
- **`package-lock.json`** - Locked dependency versions

### Git Files

- **`.gitignore`** - Files to ignore in git

## Best Practices

### File Naming

- **Components**: PascalCase (`UserProfile.tsx`)
- **Utilities**: camelCase (`formatDate.ts`)
- **Constants**: UPPER_CASE (`API_URL.ts`)
- **Types**: PascalCase (`User.ts`)

### Directory Organization

- Group by feature for complex modules
- Keep related files close together
- Use index files for clean imports
- Separate concerns (UI, logic, data)

### Import Paths

Use absolute imports with path aliases:

```typescript
import { Button } from '@/components/common/Button';
import { apiClient } from '@/lib/api/client';
import type { User } from '@/types';
```

### Code Organization

- One component per file
- Co-locate tests with source files
- Keep files small and focused
- Use barrel exports (index.ts)

## Scripts Reference

### Development
```powershell
npm run dev          # Start dev server
npm run build        # Build for production
npm run start        # Start production server
npm run lint         # Run linter
```

### Deployment
```powershell
.\scripts\deploy\deploy.ps1 -Environment production
.\scripts\aws\deploy-s3.ps1 -BucketName your-bucket
```

### Setup
```powershell
.\scripts\setup\install-dependencies.ps1
```
