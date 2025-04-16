//
//  StartupView.swift
//  Bartender
//
//  Created by Oleh Zimin on 11.04.2025.
//

import SwiftUI

struct StartupView: View {
    @State private var viewModel = StartupViewModel()
    
    var body: some View {
        if viewModel.isShowingSplash {
            SplashScreenView()
                .task {
                    await viewModel.loadData()
                }
        } else {
            TabView {
                Tab("Home", systemImage: "house") {
                    NavigationStack {
                        HomeView()
                    }
                }
                
                Tab("My Bar", systemImage: "heart") {
                    NavigationStack {
                        MyBarView()
                    }
                }
                
                Tab("Bartender", systemImage: "flask") {
                    NavigationStack {
                        BartenderView()
                    }
                }
                
                Tab("Add", systemImage: "plus") {
                    NavigationStack {
                        AddEditView()
                    }
                }
                
                Tab("Settings", systemImage: "gear") {
                    NavigationStack {
                        SettingsView()
                    }
                }
            }
        }
    }
}


#Preview {
    StartupView()
}
