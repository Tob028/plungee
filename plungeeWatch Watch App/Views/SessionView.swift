//
//  SessionView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
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
            workoutManager.startWorkout(selectedExposure: selectedExposureType)
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
