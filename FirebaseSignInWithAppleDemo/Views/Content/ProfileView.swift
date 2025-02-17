//
//  ProfileView.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 10.02.2025.
//

import SwiftUI
import FirebaseSignInWithApple
import FirebaseAuth
import FirebaseFirestore
// 1.

struct ProfileView: View {
    
    @Environment(\.firebaseSignInWithApple) private var firebaseSignInWithApple
    
    // 2.
    
    var body: some View {
        VStack {
            // 3.
            
            FirebaseSignOutWithAppleButton {
                FirebaseSignInWithAppleLabel(.signOut)
            }

            FirebaseDeleteAccountWithAppleButton {
                FirebaseSignInWithAppleLabel(.deleteAccount)
            }

            Button("Sign Out") {
                firebaseSignInWithApple.signOut()
            }
            
            Button("Delete Account") {
                firebaseSignInWithApple.deleteAccount()
            }

        }
        .navigationTitle("Profile")
        .padding()
        .onAppear {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        Task {
            do {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                // 4.
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ProfileView()
}
