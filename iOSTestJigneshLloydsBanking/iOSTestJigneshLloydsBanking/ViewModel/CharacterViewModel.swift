//
//  CharacterViewModel.swift
//  iOSTestJigneshLloydsBanking
//
//  Created by jignesh kalantri on 26/10/24.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    @Published var errorMessage: String? {
        didSet {
            // Additional logic can be added here if needed
        }
    }
    
    private var cancellables = Set<AnyCancellable>()

    func fetchCharacters() {
        NetworkManager.shared.fetchCharacters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characterResponse):
                    self.characters = characterResponse.results
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
