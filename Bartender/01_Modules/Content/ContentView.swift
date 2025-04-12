//
//  ContentView.swift
//  Bartender
//
//  Created by Oleh Zimin on 11.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var cocktails = [Cocktail]()
    let service = CocktailAPIService()
    
    var body: some View {
        List(cocktails) { cocktail in
            Text(cocktail.name)
        }
        
        Button("Fetch Data") {
            Task {
                do {
                    print("waiting...")
                    cocktails = try await service.fetchAllCocktails()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        Button("Delete", role: .destructive) {
            cocktails = []
        }
        
    }
}


#Preview {
    ContentView()
}
