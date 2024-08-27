//
//  SessionStatistic.swift
//  plungee
//
//  Created by Tobias on 12/08/2024.
//

import Foundation

struct SessionStatistics {
    var type: String
    
    var minValue: Int
    
    var maxValue: Int
    
    var avgValue: Int
    
    init(type: String, minValue: Int, maxValue: Int, avgValue: Int) {
        self.type = type
        self.minValue = minValue
        self.maxValue = maxValue
        self.avgValue = avgValue
    }
    
    func serialize() -> [String: Any] {
        return [
            "type": type,
            "minValue": minValue,
            "maxValue": maxValue,
            "avgValue": avgValue
        ]
    }
}
