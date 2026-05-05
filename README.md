# Coffee & Books iOS

Coffee & Books is a SwiftUI iOS app for a cozy café/bookshop experience.  
The app includes authentication, category browsing, product sections, books, and a settings area.

## Features

- SwiftUI interface
- Firebase Authentication
- Guest / signed-in user flow
- Firebase Firestore category fetching
- Category-based navigation
- Coffee, Drinks, Bakery, Savory, and Books sections
- Custom design system with shared colors, icons, and background
- Loading, empty, and error state support

## Tech Stack

- Swift
- SwiftUI
- Firebase Auth
- Firebase Firestore
- MVVM architecture
- Async/await
- Xcode
- GitHub / SourceTree

## Architecture

The project follows a simple MVVM structure:

```text
View → ViewModel → Service → Firebase
