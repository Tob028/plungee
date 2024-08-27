//
//  DashboardView.swift
//  plungee
//
//  Created by Tobias on 28/03/2024.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedOption: String = "Cold"
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hi, John!")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Your Statistics")
                        .font(.title)
                }
                
                Spacer()
            }
            .padding(.top, 30)
            .padding(.leading, 10)
            
            VStack {
                Picker("Select Option", selection: $selectedOption) {
                    Text("Cold").tag("Cold")
                    Text("Sauna").tag("Sauna")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 5)
            
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        ZStack {
                            Text(selectedOption)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.3))
                            
                            VStack {
                                HStack {
                                    Text("Last week")
                                        .fontWeight(.semibold)
                                        .padding([.top, .leading], 10)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                LineChartPlaceholder()
                                    .stroke(Color.black, lineWidth: 2)
                                    .padding()

                            }
                        }
                    )
                }
                .padding(.top, 5)
            
            Spacer()
        }
        .padding()
    }
}

struct LineChartPlaceholder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY),
                      control1: CGPoint(x: rect.width * 0.25, y: rect.minY),
                      control2: CGPoint(x: rect.width * 0.75, y: rect.maxY))
        
        return path
    }
}

#Preview {
    DashboardView().environmentObject(WatchConnector())
}
