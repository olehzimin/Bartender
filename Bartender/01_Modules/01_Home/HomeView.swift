//
//  HomeView.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var randomCocktails = HomeViewModel().randomCocktails
    
    #if DEBUG
    init(viewModel: HomeViewModel = HomeViewModel(), randomCocktails: [Cocktail] = HomeViewModel().randomCocktails) {
        _viewModel = State(wrappedValue: viewModel)
        _randomCocktails = State(wrappedValue: randomCocktails)
    }
    #endif
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.randomCocktails) { cocktail in
                        CocktailCardView(cocktail: cocktail)
                    }
                }
            }
            .onAppear {
                viewModel.loadData()
            }
            
            Button("Reload") {
                Task {
                    await viewModel.reloadData()
                }
            }
            
            Button("Delete",role: .destructive) {
                viewModel.eraseData()
            }
        }
    }
}

#Preview {
    HomeView()
}
