//
//  StartupView.swift
//  Bartender
//
//  Created by Oleh Zimin on 11.04.2025.
//

import SwiftUI

struct StartupView: View {
    enum TabCategory {
        case home, myBar, bartender, add, settings
    }
    
    @State private var viewModel = StartupViewModel()
    @State private var selectedTab: TabCategory = .home
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        if viewModel.isShowingSplash {
            SplashScreenView()
                .task {
                    await viewModel.fetchData()
                }
        } else {
            TabView(selection: $selectedTab) {
                NavigationStack(path: $navigationPath) {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(TabCategory.home)
                
                NavigationStack {
                    MyBarView()
                }
                .tabItem {
                    Label("My Bar", systemImage: "heart")
                }
                .tag(TabCategory.myBar)
                
                NavigationStack {
                    BartenderView()
                }
                .tabItem {
                    Label("Bartender", systemImage: "flask")
                }
                .tag(TabCategory.bartender)
                
                NavigationStack {
                    AddEditView()
                }
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
                .tag(TabCategory.add)
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabCategory.settings)
            }
            .onChange(of: selectedTab) {
                Task {
                    try? await Task.sleep(for: .seconds(0.5))
                    navigationPath = NavigationPath()
                }
            }
            
        }
    }
}


#Preview {
    StartupView()
}
