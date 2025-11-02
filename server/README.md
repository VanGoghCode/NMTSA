# Backend Server Directory

This directory contains all backend-related code including APIs, business logic, and database operations.

## Structure

```
server/
├── api/           # API route handlers
├── middleware/    # Express/custom middleware
├── controllers/   # Request controllers
├── models/        # Data models and schemas
├── services/      # Business logic services
├── utils/         # Server utility functions
├── config/        # Server configuration
└── db/            # Database connections and migrations
```

## Best Practices

- Follow RESTful API design principles
- Implement proper error handling
- Use middleware for authentication and validation
- Keep controllers thin, business logic in services
- Document APIs using OpenAPI/Swagger
- Use environment variables for sensitive data
