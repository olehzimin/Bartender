//
//  ContentView.swift
//  Bartender
//
//  Created by Oleh Zimin on 11.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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


#Preview {
    ContentView()
}
