//
//  NetworkManager.swift
//  iOSTestJigneshLloydsBanking
//
//  Created by jignesh kalantri on 27/10/24.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchCharacters(completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        let urlString = Constants.APIConstants.characterURL // Ensure this URL is correctly formatted

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle network error
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            // Check for HTTP response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            // Check for data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Attempt to decode the response
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
