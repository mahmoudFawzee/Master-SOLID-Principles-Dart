````markdown
# Mastering SOLID Principles in Dart & Flutter (Advanced Architecture Case Studies)

[![Dart Version](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-02569B.svg?logo=flutter)](https://flutter.dev)
[![Architecture Style](https://img.shields.io/badge/Architecture-SOLID%20Principles-00B0FF.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Welcome! This repository is an advanced, practical exhibition of production-grade software design utilizing the **SOLID Principles** within the Dart and Flutter ecosystems. Instead of simplistic academic snippets, these implementations solve real-world architectural challenges found in enterprise mobile applications and backends.

This project serves as a definitive portfolio piece showcasing my capability to decouple legacy monolithic codebases ("God Classes") into testable, modular, and horizontally scalable systems.

---

## 🛠️ Production Architecture Case Studies

The repository contains comprehensive, real-world domain challenges refactored from two major system concepts:

### 1. Fanni (فني) — Workshop Management & Local POS System

- **Domain Focus:** Offline-first mobile store management, local transactional ledger tracking, and checkout flows processing regional mobile wallets.
- **Architectural Problems Solved:**
  - **Type-Safe Strategy Routing:** Completely eliminated brittle string-parsing lookups (`if/else` checks on strings like `"MOCK_"` or `"WALLET_DEPOSIT"`) in background syncing loops by introducing a type-safe `enum` tracking system.
  - **The Facade Pattern Separation:** Extracted complex, multi-service checkout choreography out of the Flutter UI layer and into a clean `CheckoutFacade`. The UI layer is now completely insulated from coordinating storage writes, cart resets, and wallet API triggers.
  - **Liskov Substitution Violations:** Refactored runtime payment handlers (e.g., `InstapayGateway`) to fully satisfy core contracts safely, converting fatal application loop crashes into predictable, safe logged behaviors.

### 2. EDUNEX (إيدونيكس) — Digital E-Learning Platform

- **Domain Focus:** Multi-format automated exam grading workflows (AI Natural Language Processing vs. Asynchronous Human Review) and multi-tier role authorization channels for secondary schools.
- **Architectural Problems Solved:**
  - **Granular Interface Segregation:** Dismantled large "God Interfaces" to separate administrative streaming controls from student video playback layouts, eliminating unauthorized downcasting vulnerabilities.
  - **Dependency Inversion:** Abstracted volatile AI evaluation infrastructure behind abstract contracts (`AiEvaluator`), allowing seamless swaps between models (e.g., Gemini API) and mock testing structures.

---

## 📐 The SOLID Blueprint Applied (Flutter Deep Dive)

Here is exactly how the monolithic, single-file legacy **Fanni Shop App** was dismantled and decoupled into a clean, enterprise-grade file structure:

```text
lib/
├── models/
│   └── shop_item.dart              # Single Responsibility: Pure data model structure
├── services/
│   ├── theme_service.dart          # Isolated state management for global application themes
│   ├── products_service.dart       # Decoupled mock database supplier for available catalog tools
│   ├── cart_service.dart           # Encapsulated state management for transactional shopping carts
│   ├── payment_gateway.dart        # Polymorphic payment strategy abstraction (O/L/D Principles)
│   ├── local_storage.dart          # Abstraction over low-level smartphone flash cache drivers (Hive/SQLite)
│   ├── order_history_cache.dart    # Isolated historical transaction synchronization ledger logs
│   ├── security_util.dart          # ISP Isolation: Separated database key rotation mechanics
│   └── checkout_facade.dart        # Unified business logic facade orchestrating sub-service transactions
└── main.dart                       # Lean UI entrypoint containing decoupled widget trees and root DI
```
````

### 📝 Single Responsibility Principle (SRP)

- **Before:** A monolithic `_MonolithicFanniShopAppState` class tracking theme properties, product catalogs, order history lists, caching logic, and checkout sequences inside a single widget file.
- **After:** Total separation of concerns. The UI widgets inside `main.dart` are only responsible for rendering layout components. All state manipulation and business requirements are distributed to atomic, specialized layer contracts (`CartService`, `ThemeService`, `ProductsService`).

### 🔄 Open/Closed Principle (OCP) & Dependency Inversion (DIP)

- **Before:** The UI button layer directly instantiated concrete implementations via hardcoded scripts (`final walletProcessor = VodafoneCashGateway();`) and processed variations through highly fragile string lookup checking loops (`if (walletProvider == 'VodafoneCash')`).
- **After:** The orchestration class layer depends entirely on the abstract interface `PaymentProvider`. The checkout pipeline executes `.pay()` polymorphically. Adding new local payment methods (e.g., Fawry, Meeza, Aman) requires simply declaring a new standalone class file—leaving existing production checkout algorithms untouched.

### 👥 Liskov Substitution Principle (LSP)

- **Before:** Subclasses throwing violent, unexpected runtime `UnsupportedError` exceptions when particular configuration flags or data parameters were unmet (e.g., selecting InstaPay immediately crashed the user interface thread).
- **After:** Standardized service responses across all execution pathways. Concrete implementations (`InstapayGateway`) satisfy the contract cleanly, modifying unexpected system errors into predictable, safe logged warning reports.

### 🧩 Interface Segregation Principle (ISP)

- **Before:** Large, overlapping configurations forcing basic UI widgets to inherit or maintain completely unrelated lower-level maintenance features, such as cryptographic hardware security key updates (`rotateSecurityKeys`).
- **After:** Isolated administrative structural utilities into a separate, clean contract framework (`SecurityUtil`), entirely segregating transactional payment views from database structural management.

### 🏗️ The Facade Pattern: Clean Service Orchestration

- **Before:** Even after basic refactoring, the Flutter UI layer acted as a heavy orchestrator, manually processing sequencing operations between multiple systems inside tap callbacks:

```dart
  // LEGACY BUG-PRONE PATTERN (UI Layer forced to coordinate dependencies)
  widget._checkoutService.executeCheckout(VodafoneCashGateway("..."), totalAmount);
  widget._localStorage.writeToDisk(...);
  widget._cartService.clear();

```

- **After:** Introduced the `CheckoutFacade` design pattern to encapsulate multi-system coordination. The UI layer fires a single command to a clean boundary, which cleanly manages the domain transactions behind the scenes:

```dart
  // CLEAN FACADE IMPLEMENTATION
  final class CheckoutFacadeImpl implements CheckoutFacade {
    final CartService _cartService;
    final CheckoutService _checkoutService;
    final LocalStorage _localStorage;

    @override
    void checkout(PaymentProvider paymentProvider) {
      final totalAmount = _cartService.totalCartPrice;
      _checkoutService.executeCheckout(paymentProvider, totalAmount);
      _localStorage.writeToDisk("ORDER_${DateTime.now().millisecondsSinceEpoch}", "Total: $totalAmount EGP");
      _cartService.clear(); // Fixed unexecuted method reference bug (.clear vs .clear())
    }
  }

```

---

## 👨‍💻 For Software Engineers & Recruiters: Why This Architecture Matters

If you are a **Software Engineer** looking to learn SOLID, this repo shows you how to bridge the gap between abstract textbook theories and real-world implementation. Pay close attention to how the `CheckoutFacade` decouples the UI layer from infrastructure tools, and see how the type-safe enum mapping completely secures processing loops against human input errors.

If you are a **Recruiter or Engineering Lead**, this repository demonstrates my commitment to writing highly scalable, maintainable code. By abstracting data layers, using composition over inheritance, and keeping business logic decoupled from mobile UI frameworks, this architecture guarantees:

- **Flawless Testability:** Every service can be instantly unit-tested using standard mock assertions without initializing complex mobile platforms or real web servers.
- **Seamless Scalability:** Teams can work independently on separate features, changing out database drivers or third-party APIs without creating breaking regressions across the application.
- **Long-term Maintainability:** Technical debt is heavily minimized by enforcing strict boundaries, reducing long-term development costs for fast-growing platforms.

```

```
