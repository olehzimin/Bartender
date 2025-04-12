//
//  Cocktail.swift
//  Bartender
//
//  Created by Oleh Zimin on 12.04.2025.
//

import Foundation

struct Cocktail: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let abv: Int
    let flavor: [String]
    let glass: String
    let category: String
    let ingredients: [Ingredient]
    let special: [String]
    let garnish: String
    let preparation: String
    let imageURL: String
    
    struct Ingredient: Codable {
        let name: String
        let amount: Double
        let unit: String
    }
}

//extension Cocktail {
//    static let mock: Cocktail
//}
