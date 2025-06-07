//
//  SearchView.swift
//  Bartender
//
//  Created by Oleh Zimin on 31.05.2025.
//

import SwiftUI

struct Person: Hashable {
    let id = UUID()
    let name: String
}

struct SearchView: View {
    let numbers = [2, 3]
    let person = Person(name: "Alex")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(numbers, id: \.self) { num in
                    NavigationLink(value: num) {
                        Text("Click on me")
                    }
                }
                
            }
            .navigationDestination(for: Int.self) { num in
                Text("Hello \(num)")
            }
            
            NavigationLink(value: person) {
                Text("Click for person")
            }
            .navigationDestination(for: Person.self) { person in
                Text("Hello person \(person.name)")
            }
        }
    }
}

#Preview {
    SearchView()
}
