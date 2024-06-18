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
    
    init() {
        exposureType = ExposureType.plunge
        timeInterval = DateInterval(start: Date(), end: Date())
    }
}
