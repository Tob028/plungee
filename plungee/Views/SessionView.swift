//
//  SessionView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct SessionView: View {
    var body: some View {
        VStack {
            VStack {
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
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Button(action: doNothing) {
                    HStack {
                        Image(systemName: "pause.fill")
                        Text("Pause")
                    }
                }
                .background(.green)
                
                Button(action: doNothing) {
                    Image(systemName: "flag.checkered")
                }
                .background(.red)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

func doNothing() {
    return
}

#Preview {
    SessionView()
}
