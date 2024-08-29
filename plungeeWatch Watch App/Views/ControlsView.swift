//
//  ControlsView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 19/08/2024.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack {
            ControlButton(
                action: workoutManager.end,
                icon: "xmark",
                text: "End",
                tint: .red
            )
            
            ControlButton(
                action: workoutManager.togglePause,
                icon: workoutManager.running ? "pause" : "play.fill",
                text: workoutManager.running ? "Pause" : "Resume",
                tint: .yellow
            )
            
            ControlButton(
                action: WKInterfaceDevice.current().enableWaterLock,
                icon: "drop.fill",
                text: "Lock",
                tint: .cyan
            )
        }
    }
}

#Preview {
    ControlsView()
        .environmentObject(WorkoutManager())
}

struct ControlButton: View {
    var action: () -> Void
    var icon: String
    var text: String
    var tint: Color
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .padding(.horizontal)
            
            Text(text)
            
            Spacer()
        }
        .tint(tint)
    }
}
