//
//  MetricsView.swift
//  plungee
//
//  Created by Tobias on 16/01/2024.
//

import SwiftUI

struct MetricsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ElapsedTimeView(
                elapsedTime: 0
            )
                .foregroundStyle(.yellow)
                .fontWeight(.semibold)
            
            Text(Measurement(
                value: 87,
                unit: UnitTemperature.celsius
            ).formatted(.measurement(width: .abbreviated, usage: .person)))
            
            /*
             Text(Measurement(
                value: 21,
                unit: UnitEnergy.kilocalories
            ).formatted(.measurement(width: .abbreviated, usage: .workout)))
             */
            
            Text(112.formatted(.number.precision(.fractionLength(0))) + "bpm")
        }
        .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
    }
}

#Preview {
    MetricsView()
}
