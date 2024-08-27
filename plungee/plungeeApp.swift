//
//  plungeeApp.swift
//  plungee
//
//  Created by Tobias on 27/08/2024.
//

import SwiftUI

@main
struct plungeeApp: App {
    @StateObject private var watchConnector = WatchConnector()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(watchConnector)
                .preferredColorScheme(.light)
        }
    }
}
