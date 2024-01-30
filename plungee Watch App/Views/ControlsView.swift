//
//  ControlsView.swift
//  plungee Watch App
//
//  Created by Tobias on 23/01/2024.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button {
                        workoutManager.end()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                    .font(.title2)
                    Text("End")
                }
                
                VStack {
                    Button {
                        workoutManager.togglePause()
                    } label: {
                        Image(systemName: workoutManager.running ? "pause" : "play.fill")
                    }
                    .tint(.yellow)
                    .font(.title2)
                    Text(workoutManager.running ? "Pause" : "Resume")
                }
            }
            
            VStack {
                Button {
                    WKInterfaceDevice().enableWaterLock()
                } label: {
                    Image(systemName: "drop.fill")
                }
                .tint(.cyan)
                .font(.title2)
                Text("Lock")
            }
        }
    }
}

#Preview {
    ControlsView().environmentObject(WorkoutManager())
}
