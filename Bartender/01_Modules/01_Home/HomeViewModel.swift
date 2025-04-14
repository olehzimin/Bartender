//
//  HomeViewModel.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import Foundation

@Observable
class HomeViewModel {
    private let cacheManager = CacheManager.shared
    var cocktails: [Cocktail] = []
    
    func reloadData() {
        // fetch again data from API
    }
}
