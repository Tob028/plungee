//
//  plungeeApp.swift
//  plungee
//
//  Created by Tobias on 27/08/2024.
//

import SwiftUI

@main
struct plungeeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var databaseManager = DatabaseManager.shared
    @StateObject private var watchConnector = WatchConnector()
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(databaseManager)
                .environmentObject(watchConnector)
                .environmentObject(authManager)
                .preferredColorScheme(.light)
        }
    }
}
