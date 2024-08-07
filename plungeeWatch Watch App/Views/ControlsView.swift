//
//  ControlsView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 30/06/2024.
//

import SwiftUI
import WatchKit

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: workoutManager.end) {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                    .font(.title2)
                    Text("End")
                }
                
                VStack {
                    Button(action: workoutManager.togglePause) {
                        Image(systemName: workoutManager.running ? "pause" : "play.fill")
                    }
                    .tint(.yellow)
                    .font(.title2)
                    Text(workoutManager.running ? "Pause" : "Resume")
                }
            }
            
            HStack {
                VStack {
                    Button(action: WKInterfaceDevice.current().enableWaterLock) {
                        Image(systemName: "drop.fill")
                    }
                    .tint(.cyan)
                    .font(.title2)
                    
                    Text("Lock")
                }
            }
        }
    }
}

#Preview {
    ControlsView().environmentObject(WorkoutManager(connector: WatchIOSConnector()))
}
