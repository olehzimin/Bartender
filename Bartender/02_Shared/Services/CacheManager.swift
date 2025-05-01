//
//  CacheManager.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

class CacheManager {
    static let shared = CacheManager()
    
    private init() {
        images.countLimit = 50
        images.totalCostLimit = 1024 * 1024 * 50
    }
    
    // MARK: PROPERTIES
    private(set) var cocktails: [Cocktail] = []
    
    private var images = NSCache<NSString, UIImage>()
    
    // MARK: FUNCTIONS
    func save(cocktails: [Cocktail]) {
        self.cocktails = cocktails
        print("data saved to cache")
    }
    
    func saveImage(_ image: UIImage, for name: String) {
        images.setObject(image, forKey: NSString(string: name))
        print("image \(name) has been saved to cache")
    }
    
    func getImage(for name: String) -> UIImage? {
        print("try load image \(name) from cache...")
        if let image = images.object(forKey: NSString(string: name)) {
            print("loaded successfully")
            return image
        }
        return nil
    }
    
    func delete() {
        cocktails.removeAll()
        print("data deleted from cache")
    }
    
}
