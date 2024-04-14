//
//  WorkoutManager.swift
//  plungee
//
//  Created by Tobias on 04/04/2024.
//

import Foundation

class WorkoutManager: NSObject, ObservableObject {
    // MARK: - State Control
    
    @Published var running = false
    
    func pause() {
        //session?.pause()
    }
    
    func resume() {
        //session?.resume()
    }
    
    func togglePause() {
        if running {
            self.pause()
        } else {
            resume()
        }
    }
    
    func end() {
        //
    }

}
