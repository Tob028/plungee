//
//  SessionPagingView.swift
//  plungee
//
//  Created by Tobias on 16/01/2024.
//

import SwiftUI

struct SessionPagingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        }
        .navigationTitle(workoutManager.selectedWorkout?.id ?? "")
        .navigationBarBackButtonHidden()
        //.toolbar(.hidden)
        .onChange(of: workoutManager.running) {
            displayMetricsView()
        }
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

#Preview {
    SessionPagingView().environmentObject(WorkoutManager())
}
