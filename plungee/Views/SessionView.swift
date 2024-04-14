//
//  SessionView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var selectedExposureType: ExposureType
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ElapsedTimeView(
                    elapsedTime: 0,
                    showSubseconds: true
                )
                .foregroundStyle(.yellow)
                .fontWeight(.semibold)
                
                Text(124.formatted(.number.precision(.fractionLength(0))) + "bpm")
                
                Text(Measurement(
                    value: 87,
                    unit: UnitTemperature.celsius
                ).formatted(.measurement(width: .abbreviated, usage: .person)))
            }
            .frame(width: .infinity)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Button(action: workoutManager.togglePause) {
                    HStack {
                        Image(systemName: "pause.fill")
                        Text("Pause")
                            .bold()
                    }
                }
                .padding()
                .background(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                Spacer()
                    .frame(maxWidth: 50)
                
                Button(action: workoutManager.end) {
                    Image(systemName: "flag.checkered")
                }
                .padding()
                .background(.red)
                .clipShape(Circle())
            }
            .frame(height: 64)
            .padding(.horizontal, 7)
            .background(.black.opacity(0.6))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 35, style: .circular))
            .padding(.horizontal, 26)
            
        }
        .navigationBarBackButtonHidden()
        //.navigationTitle(selectedExposureType.id)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SessionView(selectedExposureType: .plunge)
        .environmentObject(WorkoutManager())
}
