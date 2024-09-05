//
//  MainView.swift
//  plungee
//
//  Created by Tobiáš Bednář on 05.09.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
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

#Preview {
    MainView()
}
