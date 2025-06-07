//
//  TagCapsuleView.swift
//  Bartender
//
//  Created by Oleh Zimin on 03.05.2025.
//

import SwiftUI

struct TagCapsuleView: View {
    let text: String
    var highlighted = false
    var maxWide = false
    
    private var color: Color {
        if highlighted {
            Color.pink.opacity(0.5)
        } else {
            Color.white.opacity(0.5)
        }
    }
    
    private var width: CGFloat? {
        if maxWide {
            .infinity
        } else {
            nil
        }
    }
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 24)
            .frame(height: 40)
            .frame(maxWidth: width)
            .background(color)
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}

#Preview {
    VStack {
        TagCapsuleView(text: "Hello", highlighted: true, maxWide: false)
    }
    .frame(width: 400)
    
}
