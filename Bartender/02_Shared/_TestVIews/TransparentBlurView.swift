//
//  TransparentBlurView.swift
//  Bartender
//
//  Created by Oleh Zimin on 02.06.2025.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct TransparentBlurView: UIViewRepresentable {
    var blurRadius: CGFloat = 20
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        if let backdropLayer = uiView.layer.sublayers?.first {
            if let filter = CIFilter(name:"CIGaussianBlur") {
                filter.name = "myFilter"
                backdropLayer.filters = [filter]
                backdropLayer.setValue(20,
                               forKeyPath: "filters.myFilter.inputRadius")
            }
        }
    }
}

#Preview {
    TransparentBlurView()
        .padding(20)
}
