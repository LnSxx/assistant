//
//  PieChart.swift
//  assistant
//
//  Created by Leonid Semenov on 09.01.2023.
//

import SwiftUI

struct PieChart: View {
    let values: [Double]
    let colors: [Color] = chartColors
    
    var segments: [PieSegmentData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var result: [PieSegmentData] = []
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            result.append(PieSegmentData(
                startAngle: Angle(degrees: endDeg),
                endAngle: Angle(degrees: endDeg + degrees),
                color: self.colors[i % colors.count]
            )
            )
            endDeg += degrees
        }
        if result.isEmpty {
            result.append(PieSegmentData(
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: endDeg + 360),
                color: Color.secondary.opacity(0.3))
            )
        }
        return result
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(segments, id: \.self) { segment in
                    PieSegment(data: segment)
                }
                .frame(width: geometry.size.width, height: geometry.size.width)
                Circle()
                    .fill(.background)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(
            values: [
                1,
                1
            ]
        )
    }
}

var chartColors: [Color] = [
    .mint,
    .yellow,
    .cyan,
    .orange,
    .blue,
    .pink,
    .indigo,
    .green,
    .teal,
    .purple,
    .red
]
