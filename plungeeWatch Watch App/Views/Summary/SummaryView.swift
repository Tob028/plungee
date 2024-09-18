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
                prepareAndSendSession()
            }
        }
    }
    
    func prepareAndSendSession() {
        let sessionEvents: [SessionEvent] = workoutManager.workout?.workoutEvents?.compactMap { event in
            SessionEvent(
                type: event.type.stringValue,
                startDate: event.dateInterval.start,
                endDate: event.dateInterval.end,
                metadata: event.metadata
            )
        } ?? []
        
        let sessionStatistics: [SessionStatistics] = workoutManager.workout?.allStatistics.compactMap { (quantityType, statistics) -> SessionStatistics? in
            let unit: HKUnit
            switch quantityType.identifier {
            case HKQuantityTypeIdentifier.heartRate.rawValue:
                unit = HKUnit(from: "count/min")
            default:
                return nil
            }
            
            let avgValue = statistics.averageQuantity()?.doubleValue(for: unit)
            let maxValue = statistics.maximumQuantity()?.doubleValue(for: unit)
            let minValue = statistics.minimumQuantity()?.doubleValue(for: unit)

            return SessionStatistics(
                type: quantityType.identifier,
                minValue: Int(minValue!),
                maxValue: Int(maxValue!),
                avgValue: Int(avgValue!)
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
