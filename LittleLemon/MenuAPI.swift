//
//  MenuAPI.swift
//  LittleLemon
//
//  Created by Leon Haque on 14.2.2026.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://free-food-menus-api-two.vercel.app/"
    
    func fetchMenu(category: String) async throws -> [FoodItemDTO] {
        let endPoint = "\(baseURL)\(category)"
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([FoodItemDTO].self, from: data)
        } catch {
            throw NetworkError.dataDecodingError
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case dataDecodingError
    case invalidResponse
    case other(Error)

}
