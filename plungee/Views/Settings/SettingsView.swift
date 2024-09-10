//
//  SettingsView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            VStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 130, height: 130)
                
                Text("John Doe")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding(.top, 30)
            
            Spacer()
            
            Button {
                do {
                    try authManager.signOut()
                } catch {
                    print(error.localizedDescription)
                    return
                }
            } label: {
                Text("Sign out")
                    .font(.title3)
                    .bold()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 50)
            .background(.gray.opacity(0.3))
            .shadow(radius: 30)
            .foregroundStyle(.black)
            .clipShape(Capsule())

        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthManager())
}
