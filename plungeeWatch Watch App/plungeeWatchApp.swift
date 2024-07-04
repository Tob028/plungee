//
//  plungeeWatchApp.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

@main
struct plungeeWatch_Watch_AppApp: App {
    private var watchConnector: WatchIOSConnector
    @StateObject private var workoutManager: WorkoutManager
    
    init() {
        let connector = WatchIOSConnector()
        self.watchConnector = connector
        self._workoutManager = StateObject(wrappedValue: WorkoutManager(connector: connector))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: $workoutManager.showingSummaryView) {
                    SummaryView()
                }.environmentObject(workoutManager)
        }
    }
}
