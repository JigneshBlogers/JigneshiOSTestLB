//
//  NetworkManager.swift
//  iOSTestJigneshLloydsBanking
//
//  Created by jignesh kalantri on 27/10/24.
//

import Foundation

class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacters(page: Int = 1, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(characterResponse))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
