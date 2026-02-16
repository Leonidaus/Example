//
//  README.md.swift
//  LittleLemon
//
//  Created by Leon Haque on 16.2.2026.
//

# Little Lemon - Food Menu Demo App

A mobile iOS interview demo application showcasing modern Swift development practices with automated testing and code quality tools.

## Overview

Little Lemon is an iOS app that displays food items (burgers, drinks, and desserts) fetched from a REST API. Users can browse items, apply discounts with an interactive slider, and filter by category.

## Features

- **Food Menu Display**: Browse burgers, drinks, and desserts
- **Dynamic Pricing**: Interactive slider to calculate discounted prices
- **Category Filtering**: Filter menu items by category in the options view
- **REST API Integration**: Fetches menu data from external API

## Tech Stack

- **Language**: Swift
- **Platform**: iOS
- **Architecture**: MVVM (Model-View-ViewModel)
- **Code Quality**: SwiftLint integration
- **Testing**: Unit tests & End-to-End UI tests

## API

Data is fetched from:
```
https://free-food-menus-api-two.vercel.app/
```

## Testing

The project includes comprehensive test coverage:

### Unit Tests
- **Calculator Tests**: Price calculation and discount logic
- **Network Tests**: API request/response handling
- **ViewModel Tests**: Business logic validation

### UI Tests (E2E)
- End-to-end user flows
- Category filtering
- Price discount interactions


## Setup

1. **Clone the repository**
```bash
   git clone <repository-url>
   cd LittleLemon
```

2. **Install SwiftLint** (optional)
```bash
   brew install swiftlint
```

3. **Open in Xcode**
```bash
   open LittleLemon.xcodeproj
```

4. **Build and Run**
   - Select your target device/simulator
   - Press `⌘ + R` to build and run

5. **Tests**
    - Run tests in IDE

## SwiftLint

The project uses SwiftLint to enforce code style and conventions.

**Configuration**: `.swiftlint.yml` in project root

**Run manually**:
```bash
swiftlint lint
```

SwiftLint runs automatically during build for the main app target.


## Development

### Code Quality
- All code is linted with SwiftLint
- Follow Swift API Design Guidelines
- Maintain test coverage for new features

### Testing Strategy
- Unit tests for all business logic (ViewModels, Calculators, Network layer)
- UI tests for critical user flows
- Mock network responses in unit tests

## CI/CD

The project is configured to run automated tests in the development environment:
- SwiftLint checks on every build
- Unit tests executed automatically
- UI tests run on designated test targets

