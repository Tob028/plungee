//
//  SummaryView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 26/08/2024.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var watchConnector: WatchConnectorIOS
    @Environment(\.dismiss) var dismiss
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.workout == nil {
            ProgressView("Saving Session")
                .navigationBarHidden(true)
        } else {
            ScrollView {
                VStack(alignment: .leading) {
                    SummaryMetricView(title: "Total Time",
                                      value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                        .foregroundStyle(.yellow)
                    SummaryMetricView(title: "Avg. Heart Rate",
                                      value: workoutManager.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                        .foregroundStyle(.red)


                    Button("Done") {
                        dismiss()
                        workoutManager.showingSummaryView = false
                    }
                }
                .scenePadding()
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Workout data is ready
                prepareAndSendSession()
            }
        }
    }
    
    func prepareAndSendSession() {
        let sessionEvents: [SessionEvent] = workoutManager.workout?.workoutEvents?.compactMap { event in
            SessionEvent(
                type: event.type.stringValue,
                duration: event.dateInterval,
                metadata: event.metadata
            )
        } ?? []
        
        let sessionStatistics: [SessionStatistics] = workoutManager.workout?.allStatistics.compactMap { (quantityType, statistics) in
            let unit = HKUnit(from: "count/min")
        
            let avgValue = statistics.averageQuantity()?.doubleValue(for: unit)
            let maxValue = statistics.maximumQuantity()?.doubleValue(for: unit)
            let minValue = statistics.minimumQuantity()?.doubleValue(for: unit)
            
            return SessionStatistics(
                type: quantityType.identifier,
                minValue: Int(minValue ?? 0),
                maxValue: Int(maxValue ?? 0),
                avgValue: Int(avgValue ?? 0)
            )
        } ?? []
        
        let session = Session(
            exposureType: workoutManager.selectedExposure ?? .plunge,
            startDate: workoutManager.workout?.startDate ?? Date(),
            endDate: workoutManager.workout?.endDate ?? Date(),
            events: sessionEvents,
            statistics: sessionStatistics
        )
        
        watchConnector.sendSession(workout: session)
    }
}


#Preview {
    SummaryView()
        .environmentObject(WorkoutManager())
}

struct SummaryMetricView: View {
    var title: String
    var value: String

    var body: some View {
        Text(title)
            .foregroundStyle(.white)
        Text(value)
            .font(.system(.title2, design: .rounded).lowercaseSmallCaps())
        Divider()
    }
}