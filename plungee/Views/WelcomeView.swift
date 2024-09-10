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
            VStack {
                Text("Welcome to plungee")
                    .font(.largeTitle)
                    .bold()
                
                Text("Get started on your cold therapy journey")
                    .font(.headline)
            }
            .frame(alignment: .leading)

            VStack {
                
                Button {
                    Task {
                        do {
                            try await authManager.signInGoogle()
                        } catch {
                            print(error.localizedDescription)
                            return
                        }
                    }
                } label: {
                    HStack(alignment: .center) {
                        Image(systemName: "lock.fill")
                            .font(.title)
                        
                        Text("Continue with Google")
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.3))
                    .shadow(radius: 30)
                    .foregroundStyle(.black)
                    .clipShape(Capsule())
                }
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
