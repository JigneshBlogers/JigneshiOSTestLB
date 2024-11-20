
## Project Overview

This application demonstrates:
- Fetching data from an open API using `URLSession`
- Displaying a list of items in SwiftUI with `NavigationLink` for detail views
- Error handling and displaying alert messages for network errors
- Asynchronous image loading using `AsyncImage`
- Applying best practices in MVVM architecture for separation of concerns

## Features

- **Character Listing**: Displays a list of characters from the Rick and Morty API.
- **Character Details**: Shows more information about a selected character.
- **Pull-to-Refresh**: Allows the user to refresh the list manually.
- **Error Handling**: Alerts for network and data parsing errors.
- **Loading Indicator**: Shows a loading spinner while data is being fetched.

## Technologies Used

- **SwiftUI**: For UI creation.
- **Combine**: For handling asynchronous data streams.
- **URLSession**: For network requests.
- **MVVM Architecture**: Ensures separation of concerns and clean, testable code.

## Architecture

This project uses the MVVM architecture:
- **Model**: Represents data structures for characters and API responses.
- **ViewModel**: Manages the app's data logic, fetching data, and preparing it for the view.
- **View**: SwiftUI components that bind directly to the ViewModel's `@Published` properties.

### Files and Folders

- **Models**: Contains `Character` and `CharacterResponse` structs representing API data.
- **ViewModels**: Contains `CharactersViewModel` to manage data fetching and error handling.
- **Views**: Contains SwiftUI views for displaying the list and details of characters.
- **Network**: Contains `NetworkManager`, which handles API requests.

## Requirements

- **iOS 16.0** or later
- **Xcode 13** or later

## Getting Started

### Prerequisites

Make sure you have the following installed:
- Xcode 13 or higher
- iOS 16.0 or later on a physical device or simulator



Simulator Screenshot - Clone 2 of iPhone 15 Pro - 2024-11-05 at 17.27.48.png

