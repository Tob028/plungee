//
//  WorkoutManager.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 30/06/2024.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    @Published var showingSummaryView: Bool = false {
        didSet {
            if showingSummaryView == false {
                resetWorkout()
            }
        }
    }
    
    @Published var navigationPath: [ExposureType] = []
    
    var workoutType: ExposureType = .plunge
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startWorkout(selectedExposure: ExposureType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .preparationAndRecovery
        configuration.locationType = .indoor
        
        self.workoutType = selectedExposure
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
            print("Session and builder created successfully")
        } catch {
            print("Failed to create session and builder: \(error.localizedDescription)")
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        builder?.delegate = self
        
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            if success {
                print("Workout collection started successfully")
            } else {
                print("Failed to start collection: \(error?.localizedDescription ?? "unknown error")")
            }
        }
    }

    
    func requestAuthorisation() {
        let typesToShare: Set<HKSampleType> = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set<HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .waterTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!,
            HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success {
                print("HealthKit authorization granted")
            } else {
                if let error = error {
                    print("HealthKit authorization failed: \(error.localizedDescription)")
                } else {
                    print("HealthKit authorization failed: unknown error")
                }
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
            self.pause()
        } else {
            resume()
        }
    }
    
    func end() {
        session?.end()
        showingSummaryView = true
        print("Workout ended")
    }
    
    // MARK: - Workout Metrics
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var workout: HKWorkout?
    
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            default:
                return
            }
        }
    }
    
    func resetWorkout() {
        builder = nil
        workout = nil
        session = nil
        averageHeartRate = 0
        heartRate = 0
    }
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
            print("Workout session state changed to \(toState.rawValue) from \(fromState.rawValue)")
        }
        
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                if success {
                    print("Workout collection ended successfully")
                    self.builder?.finishWorkout { (workout, error) in
                        DispatchQueue.main.async {
                            self.workout = workout
                            print("Workout finished")
                        }
                    }
                } else {
                    print("Failed to end collection: \(error?.localizedDescription ?? "unknown error")")
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: any Error) {
        print("Workout session failed with error: \(error.localizedDescription)")
    }
}

extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        print("Workout builder did collect event")
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            updateForStatistics(statistics)
        }
    }
}
