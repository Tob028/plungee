//
//  AuthManager.swift
//  plungee
//
//  Created by Tobiáš Bednář on 05.09.2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn = false
    @Published var user: User?
    
    init() {
        if let currentUser = Auth.auth().currentUser {
            Task {
                do {
                    let fetchedUser = try await DatabaseManager.shared.getUser(uid: currentUser.uid)
                    DispatchQueue.main.async {
                        self.user = fetchedUser
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            self.isLoggedIn = true
        }
    }
    
    @MainActor
    func signInGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "GoogleSignInError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Client ID found."])
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        let user = signInResult.user
        
        guard let idToken = user.idToken?.tokenString else {
            throw NSError(domain: "GoogleSignInError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No ID token found."])
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )

        let authResult = try await Auth.auth().signIn(with: credential)
        
        let userDocSnapshot = try await DatabaseManager.shared.getUserDoc(uid: authResult.user.uid)
        
        if userDocSnapshot.exists {
            let userObject = try userDocSnapshot.data(as: User.self)
            self.user = userObject
        } else {
            let newUserObject = User(
                id: authResult.user.uid,
                email: authResult.user.email ?? "",
                displayName: authResult.user.displayName ?? "",
                createdAt: Date()
            )
            
            self.user = newUserObject
            
            try await DatabaseManager.shared.saveNewUser(user: newUserObject)
        }
        
        self.isLoggedIn = true
    }
    
    @MainActor
    func signOut() throws {
        try Auth.auth().signOut()
        
        debugPrint("Provider ID = \(Auth.auth().currentUser?.providerID)")
        
        if Auth.auth().currentUser?.providerID == "google.com" {
            GIDSignIn.sharedInstance.signOut()
        }
        
        self.user = nil
        self.isLoggedIn = false
    }
}

