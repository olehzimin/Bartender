//
//  StartupViewModel.swift
//  Bartender
//
//  Created by Oleh Zimin on 16.04.2025.
//

import Foundation

@Observable
class StartupViewModel {
    private let service = CocktailAPIService.shared
    private let cacheManager = CacheManager.shared
    
    private(set) var isShowingSplash = true
    
    func loadData() async {
        do {
            let cocktails = try await service.fetchAllCocktails()
            cacheManager.save(cocktails: cocktails)
        } catch {
            print(error.localizedDescription)
        }
        
        isShowingSplash = false
    }
}
