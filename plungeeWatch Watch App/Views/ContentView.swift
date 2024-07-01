//
//  ContentView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        NavigationStack(path: $workoutManager.navigationPath) {
            List(exposureTypes) { exposureType in
                NavigationLink(exposureType.id, value: exposureType)
            }
            .navigationDestination(for: ExposureType.self, destination: { exposureType in
                SessionView(selectedExposureType: exposureType)
            })
            .listStyle(.carousel)
            .navigationTitle("plungee")
            .navigationBarTitleDisplayMode(.large)
            .onAppear() {
                workoutManager.requestAuthorisation()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(WorkoutManager())
}
