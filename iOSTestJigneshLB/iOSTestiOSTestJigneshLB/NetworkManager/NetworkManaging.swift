//
//  NetworkManaging.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 27/10/24.
//

import Foundation

// Define a protocol for the network manager to allow for easier testing
protocol NetworkManagerProtocol {
    func fetchCharacters(completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void)
}
