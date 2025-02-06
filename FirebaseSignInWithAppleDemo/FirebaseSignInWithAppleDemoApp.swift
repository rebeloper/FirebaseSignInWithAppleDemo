//
//  FirebaseSignInWithAppleDemoApp.swift
//  FirebaseSignInWithAppleDemo
//
//  Created by Alex Nagy on 05.02.2025.
//

import SwiftUI
import FirebaseSignInWithApple

@main
struct FirebaseSignInWithAppleDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .configureFirebaseSignInWithAppleWith(firestoreUserCollectionPath: Path.Firestore.profiles)
        }
    }
}
