//
//  WorkoutManager.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 21/08/2024.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    var selectedExposure: ExposureType?
    
    @Published var showingSummaryView: Bool = false {
        didSet {
            // Sheet dismissed
            if showingSummaryView == false {
                resetWorkout()
            }
        }
    }
    
    var resetNavigationPath: (() -> Void)?
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startTracking(selectedExposureType: ExposureType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .indoor
        
        self.selectedExposure = selectedExposureType
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        session?.delegate = self
        builder?.delegate = self
        
        // Start Tracking
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate, completion: { (success, error) in
            // Started
        })
    }
    
    func requestAuthorisation() {
        let typesToShare: Set<HKSampleType> = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set<HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!,
            HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .waterTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .underwaterDepth)!,
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            guard success else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    // MARK: - State Control
    
    @Published var running = false
    
    func pause() {
        session?.pause()
    }
    
    func resume() {
        session?.resume()
    }
    
    func togglePause() {
        if running {
            pause()
        } else {
            resume()
        }
    }
    
    func end() {
        session?.end()
        showingSummaryView = true
        resetNavigationPath?()
    }
    
    // MARK: - Workout Metrics
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var averageWaterTemperature: Double = 0
    @Published var waterTemperature: Double = 0
    @Published var depth: Double = 0
    
    @Published var workout: HKWorkout?
    
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }

        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                //let energyUnit = HKUnit.kilocalorie()
                //self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
                return
            case HKQuantityType.quantityType(forIdentifier: .waterTemperature):
                let temperatureUnit = HKUnit.degreeCelsius()
                self.waterTemperature = statistics.mostRecentQuantity()?.doubleValue(for: temperatureUnit) ?? 0
                self.averageWaterTemperature = statistics.averageQuantity()?.doubleValue(for: temperatureUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .underwaterDepth):
                let depthUnit = HKUnit.meter()
                self.depth = statistics.mostRecentQuantity()?.doubleValue(for: depthUnit) ?? 0
            default:
                return
            }
        }
    }
    
    func resetWorkout() {
        selectedExposure = nil
        builder = nil
        session = nil
        workout = nil
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
    }
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession,
                        didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState,
                        date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        
        if toState == .ended {
            builder?.endCollection(withEnd: Date()) { (success, error) in
                self.builder?.finishWorkout() { (workout, error) in
                    DispatchQueue.main.async {
                        self.workout = workout
                        // TODO: Send workout session to iphone
                    }
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: any Error) {
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }

    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { return }

            let statistics = workoutBuilder.statistics(for: quantityType)

            // Update the published values.
            updateForStatistics(statistics)
        }
    }
}
