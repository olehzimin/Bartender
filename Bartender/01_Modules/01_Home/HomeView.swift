//
//  HomeView.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 48) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Trending")
                        .font(.bartenderLargeTitle)
                    VStack(spacing: 4) {
                        CocktailCardView(cocktail: viewModel.firstPopular, style: .main)
                            .navigationDestination(for: Cocktail.self) { cocktail in
                                DetailsView(cocktail: cocktail)
                            }
                        
                        CocktailTagsView(cocktail: viewModel.firstPopular)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 8) {
                            ForEach(viewModel.nextPopularCocktails) { cocktail in
                                CocktailCardView(cocktail: cocktail)
                            }
                        }
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Explore")
                        .font(.bartenderLargeTitle)
                    
                    CocktailCardView(cocktail: viewModel.randomCocktail, style: .main)
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(viewModel.randomCocktails) { cocktail in
                                    CocktailCardView(cocktail: cocktail)
                                }
                            }
                        }
                        .onAppear {
                            if let last = viewModel.randomCocktails.last {
                                proxy.scrollTo(last, anchor: .trailing)
                            }
                        }
                    }
                    
                    
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
            .padding(.horizontal, 16)
            .onAppear {
                viewModel.loadData()
            }
            
        }
        
    }
}

#Preview {
    HomeView()
}
