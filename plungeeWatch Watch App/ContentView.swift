//
//  ContentView.swift
//  plungeeWatch Watch App
//
//  Created by Tobias on 27/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack() {
            List(exposureTypes) { exposureType in
                NavigationLink(exposureType.id, value: exposureType)
            }
            .navigationDestination(for: ExposureType.self, destination: { exposureType in
                //SessionView(selectedExposureType: exposureType)
                Text(exposureType.id)
            })
            .listStyle(.carousel)
            .navigationTitle("plungee")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
