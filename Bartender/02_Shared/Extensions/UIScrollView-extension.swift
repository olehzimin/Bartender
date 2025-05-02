//
//  UIScrollView-extension.swift
//  Bartender
//
//  Created by Oleh Zimin on 02.05.2025.
//

import SwiftUI

private extension UIScrollView {
    override open var clipsToBounds: Bool {
        get { false }
        set {}
    }
}
