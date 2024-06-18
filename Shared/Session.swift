//
//  Session.swift
//  plungee
//
//  Created by Tobias on 03/06/2024.
//

import Foundation

class Session {
    var exposureType: ExposureType
    
    var timeInterval: DateInterval
    
    init(exposureType: ExposureType, startDate: Date, endDate: Date) {
        self.exposureType = exposureType
        timeInterval = DateInterval(start: startDate, end: endDate)
    }
}
