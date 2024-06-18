//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("Your Summary")
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Time spent plunging")
                    Text("28 min").bold()
                }
                .padding()
                .background(.yellow)
                
                VStack(alignment: .leading) {
                    Text("Time spent plunging")
                    Text("28 min").bold()
                }
                .padding()
                .background(.yellow)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Time spent plunging")
                    Text("28 min").bold()
                }
                .padding()
                .background(.yellow)
                
                VStack(alignment: .leading) {
                    Text("Time spent plunging")
                    Text("28 min").bold()
                }
                .padding()
                .background(.yellow)
            }
        }
    }
}

#Preview {
    HomeView()
}
