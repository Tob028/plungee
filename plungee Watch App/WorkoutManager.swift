//
//  WorkoutManager.swift
//  plungee Watch App
//
//  Created by Tobias on 23/01/2024.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    /*
     var selectedWorkout: ExposureType? {
        didSet {
            guard let selectedWorkout = selectedWorkout else {
                return
            }
            startWorkout(workoutType: selectedWorkout)
        }
    }
    */
    
    @Published var navigationPath: [ExposureType] = []
    
    @Published var showingSummaryView: Bool = false {
        didSet {
            if showingSummaryView == false {
                resetWorkout()
            }
        }
    }
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startWorkout(workoutType: ExposureType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .indoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        builder?.delegate = self
        
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            // collect
        }
    }
    
    func requestAuthorisation() {
        let typesToShare: Set<HKSampleType> = [
            //HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set<HKObjectType> = [
                HKQuantityType.quantityType(forIdentifier: .heartRate)!,
                HKQuantityType.quantityType(forIdentifier: .waterTemperature)!,
                HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
                HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!,
                HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!,
            ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
                // handle
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
        navigationPath = []
        showingSummaryView = true
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
        //selectedWorkout = nil
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
        print("state change")
        DispatchQueue.main.async {
            self.running = toState == .running
            print("state change from async")
        }
        
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                // Save session and send to iphone
                extractWorkoutData(workoutBuilder: self.builder!)
                
                // Discard workout, as it's not being saved to HealthKit
                self.builder?.discardWorkout()
                
                /*
                self.builder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async {
                        self.workout = workout
                    }
                }
                */
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
    }
}

extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
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

func extractWorkoutData(workoutBuilder: HKWorkoutBuilder) {
    print("extracting")
    // Extract data from workout builder
    let statistics = workoutBuilder.allStatistics
    let samples = workoutBuilder.workoutEvents
    let workoutConfiguration = workoutBuilder.workoutConfiguration
    let startDate = workoutBuilder.startDate
    let endDate = workoutBuilder.endDate
    let totalEnergyBurned = workoutBuilder.statistics(for: HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!)
    let totalDistance = workoutBuilder.statistics(for: HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!)
    
    // Print extracted data
    print("Statistics \(statistics)")
    print("Workout Configuration: \(workoutConfiguration)")
    print("Start Date: \(String(describing: startDate))")
    print("End Date: \(String(describing: endDate))")
    print("Total Energy Burned: \(String(describing: totalEnergyBurned))")
    print("Total Distance: \(String(describing: totalDistance))")
    
    // process data
}
