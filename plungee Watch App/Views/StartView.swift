//
//  StartView.swift
//  plungee Watch App
//
//  Created by Tobias on 31/03/2024.
//

import SwiftUI

struct StartView: View {
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
        .sheet(isPresented: $workoutManager.showingSummaryView) {
            SummaryView()
        }
    }
}

#Preview {
    StartView().environmentObject(WorkoutManager())
}
