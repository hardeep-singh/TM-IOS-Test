# Technical Challenge (iOS)

This repository contains my submission for the **Technical Challenge**.

- **Xcode:** 26  
- **Language/Framework:** Swift, SwiftUI  
- **Concurrency:** Swift Structured Concurrency (async/await)  
- **Data Sources:** Live API & Mock Data (switchable)

---

## ✅ Acceptance Criteria — Status
- Display the latest **20 listings** ✔️  
- Tapping a listing row presents a default alert ✔️  
- Navigation bar with **Search** and **Cart** buttons (each shows a default alert) ✔️  
- **Tab Bar** with four tabs: _Discover_, _Notifications_, _Watchlist_, _My Trade Me_ ✔️  
- Placeholder screens for _Notifications_, _Watchlist_, and _My Trade Me_ ✔️

---

## ✨ Extras

### Dark Mode Support
- Uses semantic colors and system materials to automatically adapt to Light/Dark Mode.
- Verified contrast for primary text, secondary text, and tappable elements.

### Centralized Constants
- All user-facing strings and static values live under `App/Constants/*` to keep copy consistent and avoid magic numbers.
- Easy to localize and tweak UI text without touching view logic.
- Most views include accessibility identifiers, labels, and values where appropriate to support UI testing and VoiceOver.

### Architecture & Testability
- Code structured to be **testable** and **scalable** using **dependency inversion** (no strong coupling), making future changes safer and easier.
- Separate data models for **Remote**, **Domain (Business)**, and **UI** layers so changes in one layer don’t impact the others.

---

## 🧭 Schemes
Two schemes let you quickly switch between data sources:

- **TradeMe-Live** — uses the live API  
- **TradeMe-MockData** — uses local mock data
