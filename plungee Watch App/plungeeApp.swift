//
//  plungeeApp.swift
//  plungee Watch App
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

@main
struct plungee_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                StartView()
                Text("stats")
            }
            .environmentObject(workoutManager)
        }
    }
}
