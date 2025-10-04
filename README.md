# Technical Challenge (iOS)

This repo contains my submission for the **Technical Challenge**.

- **Xcode:** 26  
- **Tech:** Swift, SwiftUI
- **Concurrency:** Swift Structured Concurrency
- **Data Sources:** Live API & Mock Data (switchable with schemes)
- **UnitTest:** Write UnitTest
---

## ✅ Acceptance Criteria — Status
- Show the latest **20 listings** ✔️  
- Tapping a listing row shows a default alert ✔️  
- Navigation bar with **Search** and **Cart** buttons (each shows a default alert) ✔️  
- **Tab Bar** with three tabs: _Discover_, _Watchlist_, _My Trade Me_ ✔️  
- Placeholder screens for _Watchlist_ and _My Trade Me_ ✔️

---

## ✨ Extras

### Schemes

Two schemes make it easy to switch data sources:

- **TradeMe-Live** — Uses the sandbox API
- **TradeMe-MockData** — Uses a local `MockListingsViewModel` with mock data

### Dark Mode
- Uses semantic colors and system materials.

### Centralized Constants
- All user-facing strings and static values live under `App/Constants/*` (no magic numbers).
- Easy to localize or tweak copy without touching view logic.
- Most views include accessibility identifiers/labels to support UI testing and VoiceOver.

### Tests

- **ListingsViewModel** unit tests  
- **RemoteListingsLoader** unit tests  
- **Listings** feature integration tests (Loader + Mapper + ViewModel)

> Tests avoid production code paths by injecting mocks and, when the test runner is detected, switching the app mode to `.unitTests`.

### Architecture & Testability
- Clean, testable design via **dependency inversion** (no tight coupling).
- Separate models for **Remote**, **Domain**, and **UI** layers to minimize cross-impact.
- Unit tests and integration tests ensure mapping and error paths are correct.
- Tests are configured so they **do not trigger live API calls**.
- Aims for stateless design with a single source of truth, single responsibility, and no business logic in views.