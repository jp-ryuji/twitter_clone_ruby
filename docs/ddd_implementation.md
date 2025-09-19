# Domain Driven Design (DDD) Implementation

This document explains how Domain Driven Design principles have been applied to this Rails application while preserving Rails' advantages.

## Overview

The implementation follows a pragmatic approach to DDD that leverages Rails' strengths while incorporating key DDD concepts where they add value. Rather than implementing a full DDD architecture with separate layers, we've focused on the core DDD principles:

1. **Value Objects** - For data validation and integrity
2. **Application Services** - For coordinating use cases
3. **Clean Separation of Concerns** - Keeping domain logic where it belongs

## Value Objects

Value objects are used to encapsulate validation logic and ensure data integrity. They are immutable and have proper equality checks.

### Email

Validates email format and ensures consistency.

### ScreenName

Validates screen name format (alphanumeric characters and underscores, 1-15 characters).

### PostContent

Validates post content length (max 140 characters).

## Application Services

Application services coordinate between domain models and handle use cases:

### PostApplicationService

Handles post-related use cases:

- Creating posts
- Retrieving posts by user
- Retrieving posts from followed users

### UserApplicationService

Handles user-related use cases:

- User registration
- Retrieving users by screen name
- Finding users not yet followed

### FollowingApplicationService

Handles social graph use cases:

- Following/unfollowing users
- Retrieving following users
- Retrieving followers

## Benefits

This approach provides several benefits:

1. **Encapsulation** - Validation logic is contained within value objects
2. **Reusability** - Application services can be used across different contexts
3. **Testability** - Clear separation makes testing easier
4. **Maintainability** - Changes to business logic are localized
5. **Rails Integration** - Leverages Rails' strengths rather than fighting them

## Directory Structure

```plaintext
app/
├── application/           # Application services
├── models/                # ActiveRecord models (domain entities)
├── value_objects/         # Value objects
└── services/              # Legacy services (to be refactored)
```
