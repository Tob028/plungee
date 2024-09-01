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
    @StateObject private var databaseService: DatabaseManager = DatabaseManager.shared
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(databaseService)
                .environmentObject(watchConnector)
                .preferredColorScheme(.light)
        }
    }
}
