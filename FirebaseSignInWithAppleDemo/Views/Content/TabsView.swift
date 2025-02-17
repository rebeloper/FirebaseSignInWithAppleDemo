//
//  TabsView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 16.02.2025.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.circle")
                Text("Profile")
            }
            
            NavigationStack {
                AllCardsView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("All Cards")
            }
            
            NavigationStack {
                CardsView()
            }
            .tabItem {
                Image(systemName: "document.on.document")
                Text("Cards")
            }
        }
    }
}

#Preview {
    TabsView()
}
