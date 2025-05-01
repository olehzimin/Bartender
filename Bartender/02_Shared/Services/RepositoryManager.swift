//
//  RepositoryManager.swift
//  Bartender
//
//  Created by Oleh Zimin on 18.04.2025.
//

import SwiftUI

@Observable
class RepositoryManager {
    class var shared: RepositoryManager {
        RepositoryManager()
    }
    private let apiService = CocktailAPIService.shared
    private let cacheManager = CacheManager.shared
    
    fileprivate init() { }
    
    fileprivate(set) var cocktails: [Cocktail] = []
    
    func fetchNewData() async {
        do {
            let cocktails = try await apiService.fetchAllCocktails()
            cacheManager.save(cocktails: cocktails)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCachedData() {
        cocktails = cacheManager.cocktails
        print("cache loaded correctly")
    }
    
    func eraseCachedData() {
        cacheManager.delete()
    }
    
    func image(for cocktail: Cocktail) async -> UIImage {
        if let image = cacheManager.getImage(for: cocktail.name) {
            return image
        } else {
            do {
                let image = try await apiService.fetchImage(for: cocktail)
                cacheManager.saveImage(image, for: cocktail.name)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return await self.image(for: cocktail)
    }
}

#if DEBUG
@Observable
class MockRepositoryManager: RepositoryManager {
    override class var shared: MockRepositoryManager {
        MockRepositoryManager()
    }
    
    var mockCocktail: Cocktail {
        self.loadCachedData()
        
        guard let cocktail = self.cocktails.first else {
            fatalError("Unable to make a mock cocktail")
        }
        
        return cocktail
    }
    
    override func fetchNewData() async { }
    
    override func loadCachedData() {
        guard let url = Bundle.main.url(forResource: "recipes-mock.json", withExtension: nil) else {
            print("bad URL")
            return
        }
        
        guard let mockCocktails = try? JSONDecoder().decode([Cocktail].self, from: Data(contentsOf: url)) else {
            print("decoding failed")
            return
        }
        
        cocktails = mockCocktails
    }
}
#endif
