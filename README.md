# Flutter Pemobile GetX

A Flutter application implementing clean architecture with GetX state management for improved Flutter development studies.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-8A2BE2?style=for-the-badge&logo=getx&logoColor=white)
![GoRouter](https://img.shields.io/badge/GoRouter-4285F4?style=for-the-badge&logo=go&logoColor=white)

## Overview

This project serves as a learning exercise to study Flutter development with a focus on best practices and clean architecture. It implements a structured approach to mobile application development with the following key features:

- **Clean Architecture** pattern (Data, Domain, and Presentation layers)
- **GetX** for state management
- **GoRouter** for Navigation 2.0 implementation
- Custom UserActivityHandler for app idle status monitoring

## Project Architecture

The project follows a clean architecture approach with three main layers:

### 1. Data Layer

- **Data Sources**: External data providers (local or remote)
- **Models**: Data transfer objects
- **Repositories**: Implementation of domain repositories

### 2. Domain Layer

- **Entities**: Core business objects
- **Repositories**: Abstract definition of data operations
- **Use Cases**: Business logic components

### 3. Presentation Layer

- **Controllers**: Handling UI logic with GetX
- **Pages**: UI components
- **Widgets**: Reusable UI elements

### 4. Dependency Injection

- Centralized dependency management system

## Directory Structure

```text
lib
├─ app_router.dart                       # GoRouter configuration
├─ data                                  # Data layer
│  ├─ datasources                        # Data providers
│  ├─ models                             # Data transfer objects
│  └─ repositories                       # Repository implementations
├─ domain                                # Domain layer
│  ├─ entities                           # Business objects
│  ├─ repositories                       # Repository interfaces
│  └─ usecases                           # Business logic
├─ injection.dart                        # Dependency injection
├─ main.dart                             # Entry point
├─ presentation                          # Presentation layer
│  ├─ controllers                        # GetX controllers
│  └─ pages                              # UI screens
│     ├─ cv                              # CV module
│     ├─ home                            # Home module
│     ├─ list                            # List module
│     ├─ login                           # Login module
│     ├─ navigation                      # Navigation module
│     └─ profile                         # Profile module
├─ shared                                # Shared components
├─ user_activity_handler.dart            # Custom idle detector
├─ utils                                 # Utility functions
└─ widgets                               # Reusable widgets
```

## Key Features

- **CV Management**: Create and manage CV information
- **Authentication System**: User login functionality
- **Navigation Management**: Structured navigation with GoRouter
- **User Activity Monitoring**: Tracks user idle status

## Dependencies

This project utilizes the following packages:

| Package               | Version   | Purpose                               |
|-----------------------|-----------|---------------------------------------|
| get                   | ^4.7.2    | State management                      |
| go_router             | ^15.1.2   | Navigation 2.0                        |
| equatable             | ^2.0.7    | Value equality                        |
| dartz                 | ^0.10.1   | Functional programming                |
| shared_preferences    | ^2.5.3    | Local storage                         |
| url_launcher          | ^6.3.1    | URL handling                          |
| neubrutalism_ui       | ^2.0.2    | UI styling                            |
| font_awesome_flutter  | ^10.8.0   | Icons                                 |
| intl                  | ^0.20.2   | Internationalization                  |
| http                  | ^1.1.0    | Network requests                      |
| encrypt               | ^5.0.3    | Encryption                            |
| pointycastle          | ^3.6.2    | Cryptography                          |
| file_picker           | ^10.1.2   | File selection                        |
| sqflite               | ^2.4.2    | Local RDBMS                           |
| camera                | ^0.11.1   | Allowing access to the device cameras |
| image_picker          | ^1.1.2    | Image selection |

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

```bash
git clone https://github.com/X-Hozmi/flutter_pemobile_getx.git
```

2. Install dependencies:

```bash
cd Flutter_Pemobile_GetX
flutter pub get
```

3. Run the application:

```bash
flutter run
```

## Architecture Details

### Clean Architecture

This project strictly follows the principles of Clean Architecture to ensure:

- **Separation of Concerns**: Each layer has its specific responsibility
- **Dependency Rule**: Dependencies point inward only
- **Testability**: Each component can be tested in isolation
- **Independence**: UI and frameworks are isolated from business logic

### State Management with GetX

GetX is used for:

- **State Management**: Reactive state updates
- **Dependency Injection**: Simple and efficient DI system
- **Route Management**: (Supplemented with GoRouter)

### Navigation with GoRouter

GoRouter provides a declarative approach to routing with:

- **Nested Navigation**: Supporting complex navigation patterns
- **Deep Linking**: Proper handling of deep links
- **URL-based Navigation**: Web-friendly navigation

### Custom UserActivityHandler

Monitors and manages user inactivity:

- Detects when app is idle
- Provides hooks for idle-state actions (like auto-logout)

## Contributing

Feel free to submit issues or pull requests if you want to improve this project. This is primarily a learning exercise, so constructive feedback is welcome.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Flutter team for the amazing framework
- GetX community for the state management solution
- GoRouter contributors for the navigation package
