//
//  APIConstants.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 28/10/24.

/// Centralized storage for API-related constants to improve readability and maintainability.
///
import Foundation

/// Centralized storage for constants to improve readability and maintainability.
struct Constants {
    
    // MARK: - API URLs
    struct APIConstants {
        static let characterURL = "https://rickandmortyapi.com/api/character?page=1"
    }
        
    // MARK: - Error Messages
    struct ErrorMessages {
        static let invalidURL = "Invalid URL."
        static let networkError = "Network error occurred."
        static let noData = "No data returned."
        static let decodingError = "Failed to decode the response."
    }
}

struct UIConstants {
    static let navigationTitle = "Rick and Morty Characters"
    static let loadingMessage = "Loading..."
    static let errorTitle = "Error"
    static let errorUnknownMessage = "Unknown error"
}
