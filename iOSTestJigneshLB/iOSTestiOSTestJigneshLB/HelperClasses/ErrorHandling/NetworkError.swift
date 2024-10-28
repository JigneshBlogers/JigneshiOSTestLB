//
//  NetworkError.swift
//  iOSTestJigneshLB
//
//  Created by jignesh kalantri on 28/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case noData
    case decodingError(Error)
}
