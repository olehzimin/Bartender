//
//  CocktailMainCardView.swift
//  Bartender
//
//  Created by Oleh Zimin on 17.04.2025.
//

import SwiftUI

struct CocktailMainCardView: View {
    let repositoryManager: RepositoryManager
    let cocktail: Cocktail
    @State private var image: UIImage?
    
    let height: CGFloat = 220
    let footerBackground = LinearGradient(
        stops: [
            .init(color: .black, location: 0.3),
            .init(color: .clear, location: 1)
        ],
        startPoint: .bottom,
        endPoint: .top
    )
    
    init(repositoryManager: RepositoryManager = RepositoryManager.shared, cocktail: Cocktail) {
        self.repositoryManager = repositoryManager
        self.cocktail = cocktail
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .offset(x: -40, y: -70)
                        
                } else {
                    ProgressView()
                }
            }
            .frame(height: height)
            .task {
                image = await repositoryManager.image(for: cocktail)
            }
            
            Rectangle()
                .fill(footerBackground)
                .frame(height: 100)
            
            VStack(alignment: .trailing) {
                Image(systemName: "heart.fill")
                    .font(.title3)
                    
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(cocktail.name)
                        .font(.bartenderTitle)
                        
                    
                    HStack {
                        Image(systemName: "heart")
                        Text(cocktail.likes.formatted())
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text("abv \(cocktail.abv)%")
                    }
                }
            }
            .font(.bartenderBody)
            .foregroundStyle(.white)
            .padding(16)
            
        }
        .frame(height: height)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .shadow(radius: 20)
        )
        
        
    }
}

#Preview {
    let repositoryManager = MockRepositoryManager.shared
    let cocktail = repositoryManager.mockCocktail

    return CocktailMainCardView(repositoryManager: repositoryManager, cocktail: cocktail)
        .padding(16)
}
