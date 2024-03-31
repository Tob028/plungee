//
//  SessionView.swift
//  plungee Watch App
//
//  Created by Tobias on 31/03/2024.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: Tab = .metrics
    
    var selectedExposureType: ExposureType
    
    enum Tab {
        case controls, metrics
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .onChange(of: workoutManager.running) {
            displayMetricsView()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) {
            displayMetricsView()
        }
        .onAppear(perform: {
            workoutManager.startWorkout(workoutType: selectedExposureType)
        })
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

#Preview {
    SessionView(selectedExposureType: .plunge).environmentObject(WorkoutManager())
}
