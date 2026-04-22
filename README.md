# 📍 Event Explorer iOS App

A SwiftUI-based Event Explorer app that lets users browse nearby events, bookmark favorites, view event details, and navigate using Maps. Built with MVVM architecture, Core Data persistence, and offline-first support.

---

## 🚀 Features

- 📍 Browse nearby events
- 🔖 Bookmark / unbookmark events
- 📄 Event detail screen with hero image
- 🗺️ Open event location in Apple Maps
- 📶 Offline support with local caching (Core Data + JSON fallback)
- 🖼️ Image caching (memory + disk with TTL)
- 🌐 API integration with fallback to local JSON
- 🧭 Distance from user location (Core Location)

---

## 🧱 Architecture

- MVVM (Model–View–ViewModel)
- Repository pattern for data layer
- Dependency Injection (protocol-based)
- Core Data for persistence
- URLSession-based networking
- Multi-layer caching (memory + disk)

---

## 🧩 Tech Stack

- SwiftUI
- Core Data
- Core Location
- MapKit
- URLSession
- Combine / ObservableObject

---

## 📦 Data Flow

1. API fetch (Network layer)
2. DTO mapping
3. Save to Core Data
4. Fetch from Core Data → UI
5. Fallback to local JSON if API fails
6. Image loader uses memory + disk cache

---

## 🗂️ Project Structure
