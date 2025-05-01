//
//  HomeViewModel.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

@Observable
class HomeViewModel {
    fileprivate var repositoryManager = RepositoryManager.shared
    var cocktails: [Cocktail] {
        repositoryManager.cocktails
    }
    
    var randomCocktails: [Cocktail] {
        var cocktails: Set<Cocktail> = []
        while cocktails.count < 10 {
            if let randomCocktail = self.cocktails.randomElement() {
                cocktails.insert(randomCocktail)
            } else {
                break
            }
        }
        
        return Array(cocktails)
    }
    
    var randomCocktail: Cocktail? {
            self.cocktails.randomElement()
    }
    
    func loadData() {
        repositoryManager.loadCachedData()
    }
    
    func reloadData() async {
        await repositoryManager.fetchNewData()
        repositoryManager.loadCachedData()
    }
    
    func eraseData() {
        repositoryManager.eraseCachedData()
        repositoryManager.loadCachedData()
    }
}

#if DEBUG
extension HomeViewModel {
    convenience init(repositoryManager: MockRepositoryManager) {
        self.init()
        self.repositoryManager = repositoryManager
    }
}
#endif
