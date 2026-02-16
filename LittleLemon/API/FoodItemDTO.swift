//
//  FoodItemDTO.swift
//  LittleLemon
//
//  Created by Leon Haque on 16.2.2026.
//

import Foundation

struct FoodItemDTO: Codable {
    let id: String
    let img: String
    let name: String
    let dsc: String
    let price: Double
    let rating: Int
    
    enum CodingKeys: String, CodingKey {
        case id, img, name, dsc, price
        case rating = "rate"
    }
}
