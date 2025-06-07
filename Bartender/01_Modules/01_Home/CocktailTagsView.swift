//
//  CocktailTagsView.swift
//  Bartender
//
//  Created by Oleh Zimin on 03.05.2025.
//

import SwiftUI
import WrappingStack

struct CocktailTagsView: View {
    let cocktail: Cocktail?
    let spacing: CGFloat
    
    init(cocktail: Cocktail?, spacing: CGFloat = 4) {
        self.cocktail = cocktail
        self.spacing = spacing
    }
    
    var body: some View {
        if let cocktail {
            VStack(alignment: .leading, spacing: spacing) {
                HStack(spacing: spacing) {
                    
                    TagCapsuleView(
                        text: cocktail.category,
                        highlighted: true,
                        maxWide: true
                    )
                    
                    ForEach(cocktail.flavor, id: \.self) { flavor in
                        TagCapsuleView(text: flavor)
                    }
                }
                
                WrappingHStack(
                    id: \.self,
                    alignment: .leading,
                    horizontalSpacing: spacing,
                    verticalSpacing: spacing
                ) {
                    ForEach(cocktail.ingredients, id: \.self) { ingredient in
                        TagCapsuleView(text: ingredient.name)
                    }
                }
                
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    let repositoryManager = RepositoryManager.shared
    repositoryManager.loadCachedData()
    let cocktail = repositoryManager.cocktails.last!

    return CocktailTagsView(cocktail: cocktail)
}
