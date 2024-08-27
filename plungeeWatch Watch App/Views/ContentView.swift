//
//  ContentView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 19/08/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        List(exposureTypes) { item in
            NavigationLink(value: item) {
                Text(item.rawValue)
            }
        }
        .listStyle(.carousel)
        .navigationDestination(for: ExposureType.self) { type in
            SessionView(selectedExposureType: type)
        }
        .navigationTitle("plungee")
        .onAppear {
            workoutManager.requestAuthorisation()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WorkoutManager())
}
