//
//  plungeeApp.swift
//  plungee
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

@main
struct plungeeApp: App {
    @StateObject private var watchConnector = WatchConnector()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(watchConnector)
        }
    }
}
