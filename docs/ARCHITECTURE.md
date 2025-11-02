# Project Architecture

## Overview

NMTSA is built with a modern, scalable architecture using Next.js, TypeScript, and AWS services.

## Technology Stack

### Frontend
- **Framework**: Next.js 16.0.1
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **State Management**: (To be implemented - Redux/Zustand)

### Backend
- **API**: Next.js API Routes
- **Database**: PostgreSQL (to be configured)
- **Authentication**: JWT

### Infrastructure
- **Cloud Provider**: AWS
- **Storage**: S3
- **Compute**: EC2 (optional)
- **CDN**: CloudFront (optional)

## Directory Structure

```
nmtsa/
├── app/                    # Next.js app directory
├── src/                    # Frontend source code
│   ├── components/        # React components
│   ├── hooks/            # Custom hooks
│   ├── lib/              # Core libraries
│   ├── types/            # TypeScript types
│   ├── config/           # Configuration
│   └── services/         # Business logic
├── server/                # Backend code
│   ├── api/              # API routes
│   ├── controllers/      # Controllers
│   ├── models/           # Data models
│   ├── services/         # Services
│   └── middleware/       # Middleware
├── scripts/               # Automation scripts
│   ├── aws/              # AWS scripts
│   ├── deploy/           # Deployment scripts
│   └── setup/            # Setup scripts
├── tests/                 # Test files
└── docs/                  # Documentation
```

## Data Flow

1. **Client Request** → Frontend (React/Next.js)
2. **API Call** → API Client → Backend API Routes
3. **Business Logic** → Controllers → Services
4. **Data Layer** → Models → Database
5. **Response** → Client

## Security

- JWT-based authentication
- Environment variable management
- CORS configuration
- Input validation
- SQL injection prevention

## Scalability

- Modular architecture
- Separation of concerns
- Code splitting
- Lazy loading
- CDN for static assets

## Development Workflow

1. Local development with `npm run dev`
2. Testing with automated test suite
3. Build with `npm run build`
4. Deploy using automation scripts

## Best Practices

- Write clean, maintainable code
- Follow TypeScript strict mode
- Use consistent naming conventions
- Document complex logic
- Write tests for critical paths
- Keep dependencies updated
