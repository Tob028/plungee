//
//  ContentView.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView() {
                    HomeView()
                        .tag(0)
                        .toolbar(.hidden, for: .tabBar)
                    
                    StatsView()
                        .tag(1)
                        .toolbar(.hidden, for: .tabBar)
                    
                    SettingsView()
                        .tag(2)
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    MainView().environmentObject(WatchConnector())
}
