//
//  NetworkManager.swift
//  iOSTestJigneshLloydsBanking
//
//  Created by jignesh kalantri on 27/10/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacters(page: Int = 1, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(characterResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
