//
//  plungeeWatchApp.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/08/2024.
//

import SwiftUI

@main
struct plungeeWatch_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    @StateObject var watchConnector = WatchConnectorIOS()
    @State var navigationPath: [ExposureType] = []
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                ContentView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
            .environmentObject(watchConnector)
            .onAppear {
                workoutManager.resetNavigationPath = {
                    navigationPath = []
                }
            }
        }
    }
}
