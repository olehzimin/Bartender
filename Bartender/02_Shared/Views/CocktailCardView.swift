//
//  CocktailCardView.swift
//  Bartender
//
//  Created by Oleh Zimin on 17.04.2025.
//

import SwiftUI

struct CocktailCardView: View {
    var cocktail: Cocktail
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 300)
            .task {
                image = await RepositoryManager.shared.image(for: cocktail)
            }
            
            Text(cocktail.name)
                .frame(maxWidth: 200)
                .font(.title)
                .padding(.bottom)
            
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(radius: 20)
        )
        
        
    }
}

#Preview {
    let cocktail = MockRepositoryManager.shared.mockCocktail
    
    return CocktailCardView(cocktail: cocktail)
}
