//
//  MetricsView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

struct MetricsView: View {
    var body: some View {
        TimelineView(
            MetricsTimelineSchedule(from: /* workoutManager.builder?.startDate ?? */ Date())
        ) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(
                    elapsedTime: 0,
                    showSubseconds: context.cadence == .live
                )
                .foregroundStyle(.yellow)
                .fontWeight(.semibold)
                
                Text(Measurement(
                    value: 12,
                    unit: UnitTemperature.celsius
                ).formatted(.measurement(width: .abbreviated, usage: .person)))
                
                /*
                 Text(Measurement(
                 value: 21,
                 unit: UnitEnergy.kilocalories
                 ).formatted(.measurement(width: .abbreviated, usage: .workout)))
                 */
                
                Text(123.formatted(.number.precision(.fractionLength(0))) + "bpm")
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MetricsView()
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    
    init(from startDate: Date) {
        self.startDate = startDate
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(from: startDate, by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)).entries(from: startDate, mode: mode)
    }
}
