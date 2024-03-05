//
//  ElapsedTimeFormatter.swift
//  plungee
//
//  Created by Tobias on 16/01/2024.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = false
    @ObservedObject private var timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .onChange(of: showSubseconds) {
                timeFormatter.showSubseconds = showSubseconds
            }
    }
}

class ElapsedTimeFormatter: Formatter, ObservableObject {
    var componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    @Published var showSubseconds: Bool = true
    
    override func string(for obj: Any?) -> String? {
        guard let time = obj as? TimeInterval else {
            return nil
        }
        
        var formattedString = componentsFormatter.string(from: time)
        
        if (showSubseconds) {
            let hundredths = Int(TimeInterval(time).truncatingRemainder(dividingBy: 1) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            formattedString = String(format: "%@%@%0.2d", formattedString ?? "", decimalSeparator, hundredths)
        }
        
        return formattedString
    }
}

#Preview {
    ElapsedTimeView()
}
