//
//  MyBarView.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI
import WrappingStack

struct MyBarView: View {
    @State private var width: CGFloat = 0
    @State private var words = ["hello", "world", "is", "you", "unforgettable", "united", "my"]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello")
                
                WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: 4, verticalSpacing: 4) {
                    ForEach(words, id: \.self) { word in
                        TagCapsuleView(text: word, highlighted: true)
                    }
                }
                
                Button("Regenerate") {
                    words.shuffle()
                }
                .background(Color.red)
            }
            .padding()
        }
    }
    
    
}

#Preview {
    MyBarView()
}
