//
//  WatchReachableIndicator.swift
//  plungee
//
//  Created by Tobias on 04/07/2024.
//

import SwiftUI
import WatchConnectivity

struct WatchReachableIndicator: View {
    @EnvironmentObject var watchConnector: WatchConnector
    
    var body: some View {
        HStack {
            Image(systemName: "applewatch")
            
            Text(watchConnector.isReachable ? "Connected" : "Not Connected")
        }
    }
}

#Preview {
    WatchReachableIndicator().environmentObject(WatchConnector())
}
