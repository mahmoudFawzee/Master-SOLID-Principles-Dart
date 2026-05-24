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
  - **Dependency Inversion:** Abracted volatile AI evaluation infrastructure behind abstract contracts (`AiEvaluator`), allowing seamless swaps between models (e.g., Gemini API) and mock testing structures.

---

## 📐 The SOLID Blueprint Applied

### 📝 Single Responsibility Principle (SRP)

- **Before:** Monolithic Flutter widgets and backend classes managing UI states, database configurations, direct API communication, and flash cache tracking simultaneously.
- **After:** Total separation of concerns. UI files only render visual trees. Business logic, state tracking, and infrastructure calculations are cleanly isolated into explicit domain service files (`CartService`, `ProductsService`, `ThemeService`).

### 🔄 Open/Closed Principle (OCP)

- **Before:** Highly fragile modification paths where adding a new payment method (like Fawry or Meeza) or adding a new user discount rank required modifying existing core checkout pipelines and conditional logic blocks.
- **After:** Core services depend strictly on polymorphic abstract interfaces (`PaymentProvider`, `DiscountSeniorityRankBased`). Extending the app's features simply means creating a new class implementation, leaving the production core completely untouched.

### 👥 Liskov Substitution Principle (LSP)

- **Before:** Subclasses throwing unexpected runtime `UnsupportedError` or `UnimplementedError` exceptions when particular feature flags or parameters were unmet, halting processing pipelines and crashing the UI thread.
- **After:** Standardized response expectations across all pipelines. Subtypes gracefully fulfill the parent signature contract, utilizing compile-time null-safety or predictable logging states to ensure the system remains bulletproof.

### 🧩 Interface Segregation Principle (ISP)

- **Before:** Large, bloated interfaces forcing lightweight consumer components to inherit methods they didn't require or have permissions to call (such as exposing low-level DB cryptographic rotation utility triggers to checkout views).
- **After:** Split interfaces down into lean, modular operational fragments. Consumers only depend on and implement the exact slice of functionality they actually require to operate.

### 🔌 Dependency Inversion Principle (DIP)

- **Before:** High-level controller structures heavily coupled to low-level details by directly instantiating concrete instances (e.g., `new VodafoneCashGateway()`, `MockHiveBox()`) inside the widget lifecycle.
- **After:** High-level business logic modules rely solely on abstract definitions (`LocalStorage`, `NetworkClient`). Concrete drivers are initialized at the application root level and safely passed into classes via constructor injection, making the entire ecosystem instantly testable.

---

## 📁 Repository Structure

```text
lib/
├── dart_backend_challenges/
│   ├── 1_single_responsibility/     # SRP Refactoring modules
│   ├── 2_open_closed/              # OCP Polymorphic strategy models
│   ├── 3_liskov_substitution/       # LSP Safe inheritance & return states
│   ├── 4_interface_segregation/     # ISP Granular capability interfaces
│   └── 5_dependency_inversion/     # DIP Constructor injections & mocks
│
└── flutter_shop_challenge/
    ├── models/                      # Pure data representation classes
    ├── services/                    # Segregated business logic & facade layers
    └── ui/                          # Lean, decoupled UI widget trees (main.dart)
```
