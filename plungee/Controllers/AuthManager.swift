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
    
    var loginMethod: LoginMethod?
    
    init() {
        _ = Auth.auth().addStateDidChangeListener() { auth, user in
            self.isLoggedIn = user != nil
        }
    }
    
    enum LoginMethod {
        case google, apple, email
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
        
        self.loginMethod = .google
        
        let newUserObject = User(
            id: authResult.user.uid,
            email: authResult.user.email ?? "",
            displayName: authResult.user.displayName ?? "",
            createdAt: Date()
        )
        
        self.user = newUserObject
        
        try await DatabaseManager.shared.saveNewUser(user: newUserObject)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        
        if self.loginMethod == .google {
            GIDSignIn.sharedInstance.signOut()
        }
        
        self.user = nil
        self.loginMethod = nil
    }
}

