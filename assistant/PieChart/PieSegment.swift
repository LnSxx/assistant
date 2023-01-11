//
//  PieSegment.swift
//  assistant
//
//  Created by Leonid Semenov on 09.01.2023.
//

import SwiftUI

struct PieSegmentData: Hashable {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color
}

struct PieSegment: View {
    let data: PieSegmentData
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width: CGFloat = CGFloat(min(geometry.size.height, geometry.size.width))
                let height = width
                path.move(
                    to: CGPoint(
                        x: width * 0.5,
                        y: height * 0.5
                    )
                )
                path.addArc(
                    center: CGPoint(x: width * 0.5, y: height * 0.5),
                    radius: width * 0.5,
                    startAngle: Angle(degrees: -90) + data.startAngle,
                    endAngle: Angle(degrees: -90) + data.endAngle,
                    clockwise: false
                )
            }.fill(data.color)
        }
    }
}

struct PieSegment_Previews: PreviewProvider {
    static var previews: some View {
        PieSegment(
            data: PieSegmentData(
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 120),
                color: .accentColor
            )
        )
    }
}
