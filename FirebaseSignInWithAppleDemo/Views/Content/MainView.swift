//
//  MainView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 06.02.2025.
//

import SwiftUI
import FirebaseSignInWithApple

struct MainView: View {
    
    @Environment(\.firebaseSignInWithApple) private var firebaseSignInWithApple
    
    var body: some View {
        Group {
            switch firebaseSignInWithApple.state {
            case .loading:
                ProgressView()
            case .authenticating:
                ProgressView()
            case .notAuthenticated:
                AuthView()
            case .authenticated:
                TabsView()
            }
        }
        .onChange(of: firebaseSignInWithApple.state) { oldValue, newValue in
            print("FirebaseSignInWithApple state changed from \(oldValue) to \(newValue)")
        }
    }
}

#Preview {
    MainView()
}
