//
//  MetricsView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 19/08/2024.
//

import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        TimelineView(
            MetricsTimelineSchedule(
                from: workoutManager.builder?.startDate ?? Date()
            )
        ) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(
                    elapsedTime: workoutManager.builder?.elapsedTime ?? 0,
                    showSubseconds: context.cadence == .live
                )
                .foregroundStyle(.yellow)
                .fontWeight(.semibold)
                
                HStack {
                    Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + "bpm")
                        
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .font(.title3)
                }
                
                Text(Measurement(
                    value: workoutManager.waterTemperature,
                    unit: UnitTemperature.celsius
                ).formatted(.measurement(width: .abbreviated, usage: .weather)))
                
                Text(Measurement(
                    value: workoutManager.activeEnergy,
                    unit: UnitEnergy.kilocalories
                ).formatted(.measurement(width: .abbreviated, usage: .workout)))
                
                Spacer()
            }
            .font(.system(.title, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
    }
}

#Preview {
    MetricsView()
        .environmentObject(WorkoutManager())
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date

    init(from startDate: Date) {
        self.startDate = startDate
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(
            from: self.startDate,
            by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)
        ).entries(
            from: startDate,
            mode: mode
        )
    }
}
