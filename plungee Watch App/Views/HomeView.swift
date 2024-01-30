//
//  ContentView.swift
//  plungee Watch App
//
//  Created by Tobias on 15/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutTypes: [ExposureType] = [.plunge, .shower, .sauna]
    var body: some View {
        TabView {
            NavigationStack {
                List(workoutTypes) { workoutType in
                    NavigationLink(
                        workoutType.id,
                        value: workoutType
                    ).navigationDestination(for: ExposureType.self) { workoutType in
                        SessionPagingView()
                    }
                    .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
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
