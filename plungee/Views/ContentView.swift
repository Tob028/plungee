//
//  ContentView.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            TabView() {
                DashboardView()
                    .tag(0)
                    .tabItem {
                        Label("Dashboard", systemImage: "chart.xyaxis.line")
                    }
                
                StartView()
                    .tag(1)
                    .tabItem {
                        Label("Start", systemImage: "play.fill")
                    }
                
                SettingsView()
                    .tag(2)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(WatchConnector())
}
