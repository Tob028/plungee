//
//  plungeeApp.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

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
