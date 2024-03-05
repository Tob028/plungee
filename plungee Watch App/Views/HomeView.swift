//
//  ContentView.swift
//  plungee Watch App
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State var presentedWorkout: [ExposureType] = []
    var workoutTypes: [ExposureType] = [.plunge, .shower, .sauna]
    
    var body: some View {
        TabView {
            NavigationStack(path: $presentedWorkout) {
                List(workoutTypes) { workoutType in
                    NavigationLink(
                        workoutType.id,
                        value: workoutType
                    )
                    .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                    .navigationDestination(for: ExposureType.self) { workoutType in
                        SessionPagingView()
                    }
                    .onChange(of: presentedWorkout) {
                        guard let workout = presentedWorkout.last else { return }
                        workoutManager.selectedWorkout = workout
                    }
                }
                .listStyle(.carousel)
                .navigationTitle("plungee")
                .onAppear() {
                    workoutManager.requestAuthorisation()
                }
            }
            
            Text("Stats")
        }
    }
}

#Preview {
    HomeView().environmentObject(WorkoutManager())
}
