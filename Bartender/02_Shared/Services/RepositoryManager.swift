//
//  RepositoryManager.swift
//  Bartender
//
//  Created by Oleh Zimin on 18.04.2025.
//

import SwiftUI

@Observable
class RepositoryManager {
    static let shared: RepositoryManager = {
        var instance = RepositoryManager()
        #if targetEnvironment(simulator)
        instance = MockRepositoryManager()
        #endif
        return instance
    }()
    
    fileprivate init() { }
    
    // MARK: PROPERTIES
    private let apiService = CocktailAPIService.shared
    private let cacheManager = CacheManager.shared
    private(set) var state = LoadingState.idle
    
    fileprivate(set) var cocktails: [Cocktail] = []
    
    
    // MARK: FUNCTIONS
    func fetchNewData() async {
        do {
            print("fetching new data...")
            let cocktails = try await apiService.fetchAllCocktails()
            cacheManager.save(cocktails: cocktails)
            state = .cached
        } catch {
            print(error.localizedDescription)
            state = .failed
        }
    }
    
    func loadCachedData() {
        cocktails = cacheManager.cocktails
        print("cache loaded correctly")
        state = .loaded
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

enum LoadingState {
    case idle, cached, loaded, failed
}

#if targetEnvironment(simulator)
@Observable
class MockRepositoryManager: RepositoryManager {
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
    
    override func image(for cocktail: Cocktail) async -> UIImage {
        guard let uiImage = UIImage(named: "cocktail-image.jpg", in: .main, with: nil) else {
            fatalError("Cannot find image in Bundle")
        }
        
        return uiImage
    }
}
#endif
