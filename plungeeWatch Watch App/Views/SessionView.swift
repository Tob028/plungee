//
//  SessionView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

struct SessionView: View {
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Text("controls").tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        }
    }
}

#Preview {
    SessionView()
}
