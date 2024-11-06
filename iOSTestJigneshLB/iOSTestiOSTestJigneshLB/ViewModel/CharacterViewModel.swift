//
//  CharacterViewModel.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 26/10/24.
//

import Foundation
import Combine

final class CharactersViewModel: CharacterViewModelProtocol {
    @Published var characters: [Character] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false // Loading state
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

     func fetchCharacters() {
        isLoading = true // Start loading

        networkManager.fetchCharacters { [weak self] result in
            guard let self = self else { return }

            // Update loading state after fetching
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.characters = response.results
                self.errorMessage = nil
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.characters = []
            }
        }
    }

    
    func setErrorMessageNil() {
        errorMessage = nil
    }
    
    private func mapErrorToUserFriendlyMessage(_ error: Error) -> String {
        // Customize the error message for user-friendly display
        switch error {
        case is URLError:
            return "Network error. Please check your internet connection."
        case let decodingError as DecodingError:
            return "Failed to load data. Please try again."
        default:
            return "An unexpected error occurred. Please try again."
        }
    }
}
