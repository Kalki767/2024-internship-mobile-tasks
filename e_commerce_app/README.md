E-Commerce App
Overview
This project is an eCommerce application built using Flutter, following a clean architecture pattern. The app is designed to manage products through various functionalities like adding, updating, viewing, and deleting products. The application employs the BLoC pattern for state management and integrates remote data sources for data handling.

Features
Product Management: Add, update, view, and delete products.
Category Management: Organize products into categories.
Remote Data Handling: Fetch and manage data from a remote source.
State Management: Implemented using the BLoC pattern.
Project Structure
The project is organized into multiple layers following the clean architecture approach:

Domain Layer:

Defines abstract classes and interfaces for core functionalities.
Contains business logic and use cases.
Data Layer:

Contains the implementation of repositories and data sources.
Responsible for fetching and persisting data.

Presentation Layer:

Handles the UI and state management using BLoC.
Manages the interaction between the user and the application.

Folder Structure:
lib/
└── features/
    └── product/
        ├── data/
        │   ├── models/
        │   │   └── product_model.dart
        │   ├── repositories/
        │   │   └── product_repository_impl.dart
        │   ├── data_sources/
        │   │   ├── remote_data_source.dart
        │   │   └── local_data_source.dart
        ├── domain/
        │   ├── entities/
        │   │   └── product.dart
        │   ├── repositories/
        │   │   └── product_repository.dart
        │   └── use_cases/
        │       ├── get_all_products.dart
        │       ├── get_product.dart
        │       ├── insert_product.dart
        │       ├── update_product.dart
        │       └── delete_product.dart
        └── presentation/
            ├── bloc/
            │   ├── product_bloc.dart
            │   ├── product_event.dart
            │   └── product_state.dart
            ├── pages/
            │   ├── product_page.dart
            │   ├── search_page.dart
            │   ├── home_page.dart
            │   └── details_page.dart


Getting Started
Prerequisites
Flutter SDK
Dart SDK
Any IDE (e.g., Android Studio, VS Code)
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/Kalki767/2024-internship-mobile-tasks.git
cd ecommerce-app
Install dependencies:

bash
Copy code
flutter pub get
Run the application:

bash
Copy code
flutter run
Code Overview
Remote Data Source
The RemoteDataSource is responsible for fetching product data from the remote server. The implementation can be found in the remote_data_source.dart file.

Product Model
The ProductModel represents the product data structure used throughout the application. It can be found in the product_model.dart file.

Product BLoC
The ProductBloc handles the state management for product-related features. The implementation can be found in the product_bloc.dart file.

Dependency Injection
The application uses a service locator for dependency injection, which is set up in the injection_container.dart file.

