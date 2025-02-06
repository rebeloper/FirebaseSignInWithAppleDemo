//
//  ContentView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 05.02.2025.
//

import SwiftUI
import FirebaseSignInWithApple

struct ContentView: View {
    var body: some View {
        VStack {
            FirebaseSignOutWithAppleButton {
                FirebaseSignInWithAppleLabel(.signOut)
            }
            
            FirebaseDeleteAccountWithAppleButton {
                FirebaseSignInWithAppleLabel(.deleteAccount)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
