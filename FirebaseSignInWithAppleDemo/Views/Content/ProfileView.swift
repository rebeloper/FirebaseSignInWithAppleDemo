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
import FirestoreCollection


struct ProfileView: View {
    
    @Environment(\.firebaseSignInWithApple) private var firebaseSignInWithApple
    
    @State private var profilesCollection = FirestoreCollection<Profile>(path: Path.Firestore.profiles)
    
    var body: some View {
        VStack {
            
            if let profile = profilesCollection.queryDocument {
                Text("\(profile.userId)")
            }
            
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
                try await profilesCollection.fetch(id: userId)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ProfileView()
}
