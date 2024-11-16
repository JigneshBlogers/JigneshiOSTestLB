//
//  CharacterViewModel.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 26/10/24.
//

import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: ErrorMessage?
    @Published var isLoading: Bool = false
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true

        networkManager.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.characters = response.results
                    self.errorMessage = nil
                case .failure(let error):
                    self.characters = []
                    self.errorMessage = ErrorMessage(message: self.mapErrorToUserFriendlyMessage(error))
                }
            }
        }
    }

    func setErrorMessageNil() {
        errorMessage = nil
    }

    private func mapErrorToUserFriendlyMessage(_ error: Error) -> String {
        switch error {
        case is URLError:
            return "Network error. Please check your internet connection."
        case is DecodingError:
            return "Failed to load data. Please try again later."
        default:
            return "An unexpected error occurred. Please try again."
        }
    }
}
