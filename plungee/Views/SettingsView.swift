//
//  SettingsView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct SettingsView: View {
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
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
