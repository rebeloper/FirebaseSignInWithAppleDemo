//
//  AuthView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 06.02.2025.
//

import SwiftUI
import FirebaseSignInWithApple

struct AuthView: View {
    
//    @Environment(\.firebaseSignInWithApple) private var firebaseSignInWithApple
    
    var body: some View {
        VStack {
            Spacer()
            
//            Button {
//                firebaseSignInWithApple.authenticate()
//            } label: {
//                FirebaseSignInWithAppleLabel(.continueWithApple)
//            }
            
            FirebaseSignInWithAppleButton {
                FirebaseSignInWithAppleLabel(.continueWithApple)
            }

        }
        .padding()
    }
}

#Preview {
    AuthView()
}
