# Mastering SOLID Principles in Dart & Flutter (Advanced Architecture Case Studies)

[![Dart Version](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-02569B.svg?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-SOLID%20Principles-00B0FF.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Welcome. This repository demonstrates advanced, production-oriented software architecture using the **SOLID Principles** in the Dart and Flutter ecosystems.

Rather than relying on simplistic academic examples, the implementations in this repository focus on solving realistic architectural problems commonly found in enterprise mobile applications and backend systems.

This project also serves as a portfolio piece demonstrating the transformation of tightly coupled monolithic codebases ("God Classes") into scalable, testable, and maintainable systems.

---

# 🛠️ Production Architecture Case Studies

The repository contains practical architecture refactors inspired by two large-scale system domains.

## 1. Fanni (فني) — Workshop Management & Local POS System

### Domain Focus

Offline-first mobile store management, local transaction tracking, and checkout workflows supporting regional mobile wallet integrations.

### Architectural Problems Solved

#### Type-Safe Strategy Routing

Eliminated fragile string-based branching logic such as:

```dart
if (walletProvider == "VODAFONE_CASH")
```

and replaced it with strongly typed enums and strategy abstractions for safer and more maintainable processing flows.

#### Facade Pattern Separation

Extracted complex checkout orchestration logic from the Flutter UI layer into a dedicated `CheckoutFacade`.

The UI layer is now completely decoupled from:

- Storage operations
- Cart state resets
- Payment gateway coordination
- Transaction logging

#### Liskov Substitution Violations

Refactored payment gateway implementations (such as `InstapayGateway`) to properly satisfy shared contracts and prevent unexpected runtime failures.

---

## 2. EDUNEX (إيدونيكس) — Digital E-Learning Platform

### Domain Focus

Multi-format automated exam grading systems, AI-assisted evaluation workflows, asynchronous human review pipelines, and multi-role authorization systems.

### Architectural Problems Solved

#### Interface Segregation

Split large, overloaded interfaces into smaller and more focused contracts.

This removed unnecessary dependencies between:

- Student playback functionality
- Administrative moderation tools
- Streaming management systems

#### Dependency Inversion

Abstracted AI evaluation infrastructure behind contracts such as:

```dart
abstract interface class AiEvaluator
```

This allows seamless switching between:

- Gemini API integrations
- Mock evaluators for testing
- Future AI providers

without affecting the business logic layer.

---

# 📐 SOLID Principles Applied in Flutter

Below is an example of how a legacy monolithic Flutter application was restructured into a cleaner and more maintainable architecture.

```text
lib/
├── models/
│   └── shop_item.dart
│
├── services/
│   ├── theme_service.dart
│   ├── products_service.dart
│   ├── cart_service.dart
│   ├── payment_gateway.dart
│   ├── local_storage.dart
│   ├── order_history_cache.dart
│   ├── security_util.dart
│   └── checkout_facade.dart
│
└── main.dart
```

---

# 📝 Single Responsibility Principle (SRP)

## Before

A single widget class handled:

- Theme management
- Product catalogs
- Cart logic
- Order history
- Caching
- Checkout workflows

This resulted in a massive, tightly coupled UI state object.

## After

Responsibilities were separated into focused services:

- `CartService`
- `ThemeService`
- `ProductsService`
- `CheckoutFacade`

The UI layer is now responsible only for rendering and user interaction.

---

# 🔄 Open/Closed Principle (OCP) & Dependency Inversion Principle (DIP)

## Before

The UI layer directly instantiated concrete implementations:

```dart
final paymentGateway = VodafoneCashGateway();
```

and relied on fragile conditional branching:

```dart
if (walletProvider == 'VodafoneCash')
```

## After

The system now depends on abstractions:

```dart
abstract interface class PaymentProvider
```

Checkout execution becomes fully polymorphic:

```dart
paymentProvider.pay(amount);
```

Adding new payment providers such as:

- Fawry
- Meeza
- Aman

requires only creating a new implementation class without modifying existing checkout logic.

---

# 👥 Liskov Substitution Principle (LSP)

## Before

Some subclasses threw unexpected runtime exceptions such as:

```dart
throw UnsupportedError(...)
```

when unsupported scenarios occurred.

## After

All implementations now honor the base contract consistently and return predictable application behavior instead of crashing the UI thread.

---

# 🧩 Interface Segregation Principle (ISP)

## Before

Large interfaces forced unrelated classes to implement unnecessary functionality such as:

```dart
rotateSecurityKeys()
```

even when those operations were irrelevant to their domain.

## After

Responsibilities were separated into smaller contracts, isolating:

- Security management
- Payment operations
- Administrative tooling
- UI concerns

This significantly reduced coupling between unrelated modules.

---

# 🏗️ Facade Pattern — Clean Service Orchestration

## Before

The UI layer manually coordinated multiple services:

```dart
// Legacy UI orchestration
widget.checkoutService.executeCheckout(
  VodafoneCashGateway(),
  totalAmount,
);

widget.localStorage.writeToDisk(...);

widget.cartService.clear();
```

This created:

- Tight coupling
- Difficult testing
- Repeated orchestration logic
- Higher bug risk

## After

A dedicated `CheckoutFacade` centralizes orchestration logic:

```dart
final class CheckoutFacadeImpl implements CheckoutFacade {
  final CartService _cartService;
  final CheckoutService _checkoutService;
  final LocalStorage _localStorage;

  CheckoutFacadeImpl(
    this._cartService,
    this._checkoutService,
    this._localStorage,
  );

  @override
  void checkout(PaymentProvider paymentProvider) {
    final totalAmount = _cartService.totalCartPrice;

    _checkoutService.executeCheckout(
      paymentProvider,
      totalAmount,
    );

    _localStorage.writeToDisk(
      "ORDER_${DateTime.now().millisecondsSinceEpoch}",
      "Total: $totalAmount EGP",
    );

    _cartService.clear();
  }
}
```

The Flutter UI now communicates with a single clean abstraction instead of coordinating multiple systems directly.

---

# 👨‍💻 Why This Architecture Matters

## For Software Engineers

This repository demonstrates how to apply SOLID principles beyond textbook examples and use them in practical Flutter architectures.

Key takeaways include:

- Decoupling UI from business logic
- Using abstractions instead of concrete implementations
- Building scalable service layers
- Applying composition over inheritance
- Designing testable systems

---

## For Recruiters & Engineering Leads

This repository demonstrates:

- Scalable architecture design
- Strong separation of concerns
- Clean dependency management
- Maintainable code organization
- Production-oriented engineering practices

### Benefits of This Architecture

#### Testability

Services can be unit-tested independently without requiring Flutter UI initialization or external infrastructure.

#### Scalability

Teams can develop features independently with minimal regression risk.

#### Maintainability

Strict architectural boundaries reduce technical debt and simplify long-term feature expansion.

#### Extensibility

New payment providers, AI evaluators, storage systems, or external APIs can be integrated with minimal impact on existing code.

---

# 📌 Core Concepts Demonstrated

- SOLID Principles
- Clean Architecture
- Facade Pattern
- Strategy Pattern
- Dependency Injection
- Composition over Inheritance
- Service Layer Architecture
- Decoupled Flutter UI
- Scalable State Management
- Testable Business Logic

---

# 📄 License

This project is licensed under the MIT License.
