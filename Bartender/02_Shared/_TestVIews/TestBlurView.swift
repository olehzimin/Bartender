//
//  TestBlurView.swift
//  Bartender
//
//  Created by Oleh Zimin on 02.06.2025.
//

import SwiftUI

struct TestBlurView: View {
    var body: some View {
        ScrollView {
            TransparentBlurView()
                .frame(height: 160)
                .visualEffect { view, proxy in
                    var offset = proxy.frame(in: .scrollView).minY * -1
                    return view.offset(y: offset)
                }
                .zIndex(1000)
            
            VStack {
                GeometryReader {
                    let size = $0.size
                    
                    Image("nature")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(height: 400)
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    TestBlurView()
}
