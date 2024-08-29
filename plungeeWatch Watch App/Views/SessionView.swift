//
//  SessionView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 19/08/2024.
//

import SwiftUI
import WatchKit

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
        .onAppear {
            workoutManager.startTracking(selectedExposureType: selectedExposureType)
        }
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic)
        )
        .onChange(of: workoutManager.running) {
            displayMetricsView()
        }
        .onChange(of: WKInterfaceDevice.current().isWaterLockEnabled) { oldValue, newValue in
            if (newValue) {
                displayMetricsView()
            }
        }
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

#Preview {
    SessionView(selectedExposureType: .plunge)
        .environmentObject(WorkoutManager())
}
