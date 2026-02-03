# Clean Architecture and SwiftUI News Feed App : NewsFeedTest

## Overview

NewsFeedTest is an iOS application designed with Clean Architecture principles and SwiftUI modularity. This project demonstrates a scalable, maintainable, and testable architecture, leveraging dependency injection, protocol-oriented programming, and clear separation of concerns.

## Project Structure

The project is organized into distinct layers, each responsible for specific concerns:

- **App**: Entry point and application lifecycle management.
- **Presentation**: UI components and view models.
- **Domain**: Business logic and use cases.
- **Data**: Data sources and repositories.
- **Infrastructure**: Configuration, network, and utilities.
- **Sourcery**: Mock genration configuration


## Layer Responsibilities

### App

**NewsFeedTestApp.swift**: Entry point of the application, responsible for setting up the main window and initializing the dependency injection.

### Presentation

**News.View**: Contains SwiftUI views responsible for the UI layout and presentation.

- **NewsRootView.swift**: Main view displaying the list of fetched news.
- **ArticleRowView.swift**: Subview displaying individual Article list items.
- **ArticleDetailView.swift**: Subview displaying individual Article details.

**News.ViewModel**: Contains view models that manage UI state and interact with the domain layer.

- **NewsViewModel.swift**: View model for managing news data presentation logic.

### Domain

**Interfaces**: Defines protocols for repositories and data sources, ensuring a clear contract between layers.

- **FetchNewsUseCase.swift**: Protocol for fetch news data usecase.
- **NewsRepository.swift**: Protocol for news repositories.
- **NewsDataSource.swift**: Protocol for news data source. 

**UseCases**: Contains business logic and application-specific rules.

- **FetchNewsUseCaseImpl.swift**: Use case implementation for fetching newws data.

**Entities**: Contains business models representing core domain objects.

- **NewsFeed.swift**, **Source.swift**, **Article.swift**: Domain models for news data.

### Data

**Remote**: Contains data sources for fetching data from remote APIs.

- **RemoteNewsDataSource.swift**: Implementation of news data source using remote APIs.

**Local**: this sample could be further refined by implementing a local datasource and handle fetching data from cached dataset or even local db.

**Repositories**: Coordinates between data sources and domain layer, transforming data as needed.

- **NewsRepositoryImpl.swift**: Implementation of news repository.

### Infrastructure

**Network**: Manages network communication details.

- **APIClient.swift**: Handles HTTP requests and responses.
- **APIResponse.swift**: Represents the result of an HTTP request executed by APIClient provides a concrete type for mocking purposes (Sourcery can't handle genrics well)
- **HTTPMethod.swift**: Enum for HTTP methods.
- **NewsAPIConfiguration.swift**: Constructs URLs for API endpoints.

**Configuration**: Manages application configurations.

- **ConfigurationManager.swift**: Implementation of ConfigurationManagerProtocol.

**Interfaces**: Defines protocols for infrastructure components.

- **APIResponseProtocol.swift**: Protocol for APIResponse.
- **APIClientProtocol.swift**: Protocol for API client.
- **ConfigurationManagerProtocol.swift**: Protocol for configuration.

## Project Review

The project leverages dependency injection to manage dependencies between layers. This ensures loose coupling and enhances testability. Dependencies are injected through initializers, allowing for easy substitution of implementations during testing.
The also leverages Swift Testing and Sourcery generated mocks for a set of clean easy to read unit tests

**Enhancements**: further enhancements were omitted for time purposes
- **Hashing sensitive data** use sourcery to handle encryption of the apikey and api base url
- **Local Data Souce** add a secondary implementation of NewsDataSource to handle local data fetching
- **Data Caching** cache the latest search locally to provide some kind of offline feature
- **Lazy Loading/pull to refresh** for an overall better user experience and easier scrolling
- **Better Design** i'm a developer not a designer sorry not sorry 😂
