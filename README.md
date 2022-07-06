# Trending Music Album Swift App

## Features
- Shows top 100 music albums in US
- Displays album name, album cover, artist name
- Cache album data for offline mode
- Updates cache on app launch with latest list

## Architecture

Source code follows MVVM archiecture

### Modules
- Albums List
- Album Detail

Source code adapts following design patterns:

### Design Patterns
- Repository Pattern
  * Data fetching from API
  * Caching to Realm database
- Coordinator Pattern
  * Managing flow between modules

## Requirements
To run this app:
- Swift 5
- iOS 13+
- Xcode 13.1+
- Cocoapods 1.10.2+

## Building the code
1. Clone the repository:
    ```shell
    git clone https://github.com/afnanahmad/trending-music.git
    ```
1. Install Cocoapods
     ```shell
    pod install
    ```
1. Open `Trending Music.xcworkspace` in Xcode.
1. Build the `Debug` scheme in Xcode.