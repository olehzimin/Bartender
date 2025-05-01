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
    @State private var randomCocktail: Cocktail?
    
    #if DEBUG
    init(viewModel: HomeViewModel = HomeViewModel(), randomCocktails: [Cocktail] = HomeViewModel().randomCocktails) {
        _viewModel = State(wrappedValue: viewModel)
        _randomCocktails = State(wrappedValue: randomCocktails)
        _randomCocktail = State(wrappedValue: randomCocktails.first)
    }
    #endif
    
    var body: some View {
        VStack {
            if let randomCocktail {
                CocktailMainCardView(cocktail: randomCocktail)
            } else {
                ProgressView()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.randomCocktails) { cocktail in
                        CocktailCardView(cocktail: cocktail)
                    }
                }
                .padding(.horizontal, 16)
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
    let repositoryManager = MockRepositoryManager.shared
    
    return HomeView(viewModel: HomeViewModel(repositoryManager: repositoryManager))
}
