//
//  CharacterViewModel.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 26/10/24.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false // New loading state

    func fetchCharacters() {
        isLoading = true // Start loading
        NetworkManager.shared.fetchCharacters { result in
            DispatchQueue.main.async {
                self.isLoading = false // Stop loading
                switch result {
                case .success(let characterResponse):
                    self.characters = characterResponse.results
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = self.mapErrorToUserFriendlyMessage(error)
                }
            }
        }
    }
    
    private func mapErrorToUserFriendlyMessage(_ error: Error) -> String {
        // Customize the error message for user-friendly display
        switch error {
        case is URLError:
            return "Network error. Please check your internet connection."
        default:
            return "An unexpected error occurred. Please try again."
        }
    }
}
