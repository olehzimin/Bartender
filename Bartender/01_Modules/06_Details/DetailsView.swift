//
//  DetailsView.swift
//  Bartender
//
//  Created by Oleh Zimin on 31.05.2025.
//

import SwiftUI

struct DetailsView: View {
    private let repositoryManager = RepositoryManager.shared
    let cocktail: Cocktail
    @State private var image: UIImage?
//    @State private var scrollPosition = ScrollPosition()
    @State private var scrollOffset = 0.0
    @State private var imageBlur = 0.0
    @State private var imageScale = 1.0
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.black
                    .ignoresSafeArea()
                
                
                Group {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .ignoresSafeArea()
                            .blur(radius: imageBlur)
                            .scaleEffect(imageScale)
                    } else {
                        ProgressView()
                    }
                }
                .task {
                    image = await repositoryManager.image(for: cocktail)
                }
                
            }
            ScrollView {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: geo.frame(in: .named("ScrollView")).origin
                                )
                        }
                        .frame(height: 0)
                        
                        LazyVStack(alignment: .leading, spacing: 24, pinnedViews: .sectionHeaders) {
                            Spacer()
                                .containerRelativeFrame(.vertical) { height, _ in
                                    height * 0.7
                                }
                            
                            Section {
                                ZStack(alignment: .bottomTrailing) {
                                    VStack(alignment: .leading, spacing: 24) {
                                        Text(cocktail.description)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.bartenderBody)
                                            .foregroundStyle(.white)
                                        
                                        HStack(spacing: 4) {
                                            TagCapsuleView(
                                                text: cocktail.category,
                                                highlighted: true,
                                                maxWide: true
                                            )
                                            
                                            ForEach(cocktail.flavor, id: \.self) { flavor in
                                                TagCapsuleView(text: flavor)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text("Preparation")
                                                .font(.bartenderTitle)
                                            
                                            Text(cocktail.preparation)
                                                .font(.bartenderBody)
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                                                    HStack(spacing: 4) {
                                                        TagCapsuleView(text: ingredient.name)
                                                        
                                                        Text(ingredient.amount, format: .number.precision(.fractionLength(2)))
                                                        
                                                        Text(ingredient.unit)
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                        }
                                        .foregroundStyle(.white)
                                        
                                        if !cocktail.special.isEmpty {
                                            VStack(alignment: .leading, spacing: 12) {
                                                Text("Special")
                                                    .font(.bartenderTitle)
                                                
                                                VStack(alignment: .leading, spacing: 4) {
                                                    ForEach(cocktail.special, id: \.self) { special in
                                                        Text(special)
                                                    }
                                                }
                                            }
                                            .foregroundStyle(.white)
                                        }
                                        
                                        if !cocktail.garnish.isEmpty {
                                            VStack(alignment: .leading, spacing: 12) {
                                                Text("Garnish")
                                                    .font(.bartenderTitle)
                                                
                                                Text(cocktail.garnish)
                                            }
                                            .foregroundStyle(.white)
                                        }
                                        
                                        
                                    }
                                    
                                    ProcentWheelView(value: cocktail.abv)
                                        .frame(width: 100, height: 100)
                                }
                            } header: {
                                Text(cocktail.name)
                                    .font(.bartenderLargeTitle)
                                    .foregroundStyle(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.clear)
                                    )
                            }
                            
                        }
                        .padding(.horizontal, 16)
                        
                    }
                    .coordinateSpace(name: "ScrollView")
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        scrollOffset = value.y
                        changeBackgroundImage()
                    }
            }
        
    }
    
    func changeBackgroundImage() {
        var blurResult: Double
        var scaleResult: Double
        
        blurResult = 10 * scrollOffset / -600
        switch blurResult {
        case 0..<10:
            imageBlur = blurResult
        case 10...:
            imageBlur = 10
        default:
            imageBlur = 0
        }
        
        scaleResult = (0.25 * scrollOffset / -600) + 1
        switch scaleResult {
        case 1..<1.25:
            imageScale = scaleResult
        case 1.25...:
            imageScale = 1.25
        default:
            imageScale = 1
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

#Preview {
    let repositoryManager = RepositoryManager.shared
    repositoryManager.loadCachedData()
    let cocktail = repositoryManager.cocktails.first!
    
    return DetailsView(cocktail: cocktail)
}
