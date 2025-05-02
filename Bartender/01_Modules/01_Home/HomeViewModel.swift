//
//  HomeViewModel.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

@Observable
class HomeViewModel {
    private var repositoryManager = RepositoryManager.shared
    private var cocktails: [Cocktail] {
        repositoryManager.cocktails.sorted { $0.likes > $1.likes }
    }
    
    var firstPopular: Cocktail? {
        cocktails.first
    }
    
    var nextPopularCocktails: [Cocktail] {
        var cocktailsSequence: Array<Cocktail>.SubSequence = []
        if !cocktails.isEmpty {
            cocktailsSequence = cocktails[1...7]
        }
        
        return Array(cocktailsSequence)
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
