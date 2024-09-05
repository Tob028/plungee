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
    @Published var isLoggedIn = false
    var loginMethod: LoginMethod?
    
    init() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            self.isLoggedIn = user != nil
        }
    }
    
    enum LoginMethod {
        case google, email
    }
    
    func signInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.loginMethod = .google
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            if self.loginMethod == .google {
                GIDSignIn.sharedInstance.signOut()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

