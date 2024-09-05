//
//  ContentView.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var isLoggedIn = Auth.auth().currentUser != nil
    
    var body: some View {
        NavigationStack {
            if (authManager.isLoggedIn) {
                MainView()
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
