//
//  ContentView.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var databaseManager: DatabaseManager
    
    var body: some View {
        NavigationStack {
            TabView() {
                DashboardView()
                    .tag(0)
                    .tabItem {
                        Label("Dashboard", systemImage: "chart.xyaxis.line")
                    }
                
                CalendarView()
                    .tag(1)
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
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
    ContentView()
        .environmentObject(DatabaseManager.shared)
}
