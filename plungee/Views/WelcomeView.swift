//
//  WelcomeView.swift
//  plungee
//
//  Created by Tobiáš Bednář on 02.09.2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            Text("Welcome to plungee")
                .font(.largeTitle)
                .bold()

            VStack {
                
                Button {
                    authManager.signInGoogle()
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                        
                        Text("Continue with Google")
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    .shadow(radius: 10)
                    .foregroundStyle(.black)
                    .clipShape(Capsule())
                }
                
                /*
                Text("Login")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))

                Text("Sign Up")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                 */
            }
            .scenePadding()
        }
        .scenePadding()
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthManager())
}
