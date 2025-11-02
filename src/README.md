# Frontend Source Directory

This directory contains all frontend-related code for the application.

## Structure

```
src/
├── components/       # React components
│   ├── common/      # Reusable components (Button, Input, etc.)
│   ├── layout/      # Layout components (Header, Footer, Sidebar)
│   └── ui/          # UI-specific components
├── hooks/           # Custom React hooks
├── lib/             # Core libraries and utilities
│   ├── api/         # API client and endpoints
│   ├── utils/       # Utility functions
│   └── validators/  # Validation schemas (Zod, Yup, etc.)
├── types/           # TypeScript type definitions
├── styles/          # Global styles and themes
├── config/          # Frontend configuration
├── services/        # Business logic services
├── contexts/        # React contexts
└── store/           # State management (Redux, Zustand, etc.)
```

## Best Practices

- Keep components small and focused
- Use TypeScript for type safety
- Follow the component naming convention: PascalCase
- Export components using named exports
- Co-locate tests with components
