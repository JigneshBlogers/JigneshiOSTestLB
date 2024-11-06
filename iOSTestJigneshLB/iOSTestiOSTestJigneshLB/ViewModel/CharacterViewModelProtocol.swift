//
//  CharacterViewModelProtocol.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 05/11/24.
//

import Foundation

protocol CharacterViewModelProtocol: ObservableObject {
    var characters: [Character] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchCharacters()
}
