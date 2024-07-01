//
//  plungeeWatchApp.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

@main
struct plungeeWatch_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: $workoutManager.showingSummaryView) {
                    SummaryView()
                }
                .environmentObject(workoutManager)
        }
    }
}
