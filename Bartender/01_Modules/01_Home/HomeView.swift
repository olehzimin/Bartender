//
//  HomeView.swift
//  Bartender
//
//  Created by Oleh Zimin on 14.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.cocktails) { cocktail in
                Text(cocktail.name)
            }
            
            Button("Reload") {
                Task {
                    await viewModel.reloadData()
                }
            }
            
            Button("Delete",role: .destructive) {
                viewModel.eraseData()
            }
        }
    }
}

#Preview {
    HomeView()
}
