# Mastering SOLID Principles in Dart & Flutter (Advanced Architecture Case Studies)

[![Dart Version](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)
[![Architecture Style](https://img.shields.io/badge/Architecture-SOLID%20Principles-emerald.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Welcome! This repository is a practical exhibition of production-grade software design using the **SOLID Principles** within the Dart and Flutter ecosystems. Instead of simplistic academic code snippets, these implementations solve real-world architectural issues found in production mobile backends, including localized workflows, multi-tier data structures, polymorphic strategies, and offline ledger sync.

This project serves as a portfolio piece showcasing my capability to decouple legacy monolithic codebases ("God Classes") into testable, scalable, and highly maintainable systems.

---

## 🛠️ Production Architecture Case Studies

The repository breaks down into comprehensive, real-world domain challenges derived from two major platform systems:

### 1. Fanni (فني) — Workshop Management & Local POS System

- **Domain Focus:** Offline ledger tracking, localized technician maintenance operations (EGP), and cross-border currency models.
- **Architectural Problems Solved:**
  - Eliminated runtime conditional blocks (`if/else` ranking engines) by implementing a polymorphic **Strategy Pattern** for dynamic technician payout rates.
  - Inverted low-level networking and hardware encryption dependencies via constructor-based **Dependency Injection (DI)**, moving away from hardcoded instantiations.
  - Resolved fragile error handling in offline background syncing loops to satisfy strict **Liskov Substitution Principle (LSP)** standards without execution failures.

### 2. EDUNEX (إيدونيكس) — Arabic Educational Technology Platform

- **Domain Focus:** Multi-format automated exam grading workflows (AI Natural Language Processing vs. Asynchronous Human Teacher Review) and multi-tier role authorization channels.
- **Architectural Problems Solved:**
  - Successfully decoupled massive, bloated interfaces into granular, capability-oriented contracts (**Interface Segregation Principle - ISP**).
  - Separated streaming controls (`StreamRole`) from administrative layout actions (`VideoPlaybackOperation`), preventing unauthorized downcasting risks for student accounts.
  - Refactored synchronous AI validation tools (`GeminiAIEvaluator`) to rely fully on clean abstract contracts (`AiEvaluator`).

---

## 📐 The SOLID Blueprint Applied

### 📝 Single Responsibility Principle (SRP)

- **The Transformation:** Moved from monolithic engines that managed application state, executed logging protocols, initialized network drivers, and handled local caching concurrently.
- **The Result:** Isolated systems into single-purpose components (Repositories manage arrays, Services execute calculations, and Infrastructure clients deal with HTTP/Hive inputs).

### 🔄 Open/Closed Principle (OCP)

- **The Transformation:** Replaced brittle, hardcoded string lookups and `if/else` blocks checking for user positions or transaction styles.
- **The Result:** Extended logic naturally by creating clean base abstract classes (`DiscountSeniorityRankBased`). Adding new operational tiers (e.g., `SeniorDiscount`, `StaffRank`) now requires writing a new class—leaving existing code completely untouched.

### 👥 Liskov Substitution Principle (LSP)

- **The Transformation:** Removed dangerous structural habits where subclasses threw unexpected runtime `UnimplementedError` or `UnsupportedError` exceptions due to unmet parent parameters.
- **The Result:** Standardized method behaviors across pipelines. Subclasses now fulfill the parent signature contract seamlessly by leveraging compile-time null-safety (`double?`) to handle asynchronous or missing results safely.

### 🧩 Interface Segregation Principle (ISP)

- **The Transformation:** Dismantled large "God Interfaces" that forced simple worker classes to implement complex methods they didn't require or have permission to access.
- **The Result:** Split interfaces down into modular, atomic operational fragments (e.g., separating basic text outputs from rich-media push modifications). Classes now compose exactly what they require via multi-interface implementation (`implements ContractA, ContractB`).

### 🔌 Dependency Inversion Principle (DIP)

- **The Transformation:** Removed tight-coupling side-effects caused by initializing direct concrete instances using the `new` keyword within service layers.
- **The Result:** Elevated modules to depend strictly on abstract boundaries (`HttpClient`, `LocalStorage`). Concrete instances are safely injected via class constructors, rendering the entire system highly testable and ready for Mock assertions.

---

## 📁 Repository Structure

```text
lib/
├── solid/
│   ├── 1_single_responsibility/     # SRP Refactoring modules
│   ├── 2_open_closed/              # OCP Polymorphic strategy models
│   ├── 3_liskov_substitution/       # LSP Safe inheritance & return states
│   ├── 4_interface_segregation/     # ISP Granular capability interfaces
│   └── 5_dependency_inversion/     # DIP Constructor injections & mocks
└── full_challenges/
    ├── fanni_workshop/              # Before vs After architecture files
    └── edunex_platform/             # Enterprise multi-domain refactoring
```
