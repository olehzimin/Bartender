//
//  CacheManager.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import Foundation

@Observable
class CacheManager {
    static let shared = CacheManager()
    
    private(set) var cachedCocktails: [Cocktail] = []
    
    private init() { }
    
    func save(cocktails: [Cocktail]) {
        cachedCocktails = cocktails
    }
    
    func delete() {
        cachedCocktails = []
        print("data deleted from cache")
    }
    
}
