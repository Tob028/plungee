//
//  StartView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    //@StateObject var watchConnector = WatchConnector()
    
    var body: some View {
        VStack {
            Text("Hello, [name]")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text("Time spent plunging")
                Text("28 min").bold()
            }
            .padding()
            
            WatchReachableIndicator()
        }
    }
}

#Preview {
    HomeView().environmentObject(WatchConnector())
}
