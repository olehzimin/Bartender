//
//  CocktailCardView.swift
//  Bartender
//
//  Created by Oleh Zimin on 17.04.2025.
//

import SwiftUI

struct CocktailCardView: View {
    private let repositoryManager = RepositoryManager.shared
    let cocktail: Cocktail?
    var style: CardStyle = .normal
    @State private var image: UIImage?
    
    var size: (width: CGFloat, height: CGFloat) {
        switch style {
        case .normal:
            (200, 300)
        case .main:
            (.infinity, 220)
        }
    }
    
    var offset: CGSize {
        switch style {
        case .normal:
            CGSize(width: 0, height: -30)
        case .main:
            CGSize(width: -40, height: -70)
        }
    }
    
    let footerBackground = LinearGradient(
        stops: [
            .init(color: .black, location: 0.3),
            .init(color: .clear, location: 1)
        ],
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        NavigationLink(value: cocktail) {
            ZStack(alignment: .bottom) {
                if let cocktail {
                    Group {
                        if let image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .offset(offset)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: size.height)
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
                } else {
                    Rectangle()
                        .fill(.black)
                }
                
            }
            .frame(height: size.height)
            .frame(maxWidth: size.width)
            .background(
                Rectangle()
                    .fill(Color.black)
                    .shadow(radius: 20)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
        }
    }
        
}

enum CardStyle {
    case normal, main
}

#Preview {
    let repositoryManager = RepositoryManager.shared
    repositoryManager.loadCachedData()
    let cocktail = repositoryManager.cocktails.first!

    return CocktailCardView(cocktail: cocktail)
}
