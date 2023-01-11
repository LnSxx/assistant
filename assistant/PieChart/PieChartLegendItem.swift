//
//  PieChartLegendItem.swift
//  assistant
//
//  Created by Leonid Semenov on 11.01.2023.
//

import SwiftUI

struct PieChartLegendItem: View {
    var data: PieChartLegendCategoryValue
    
    var textColor: Color {
        switch data.color {
        case .yellow, .mint:
            return .black
        default:
            return .white
        }
    }
    
    var body: some View {
        HStack() {
            Text(data.name)
            Text(String(data.amount))
                .fontWeight(.bold)
        }
        .foregroundColor(textColor)
        .padding(3)
        .padding(.leading)
        .padding(.trailing)
        .background(data.color)
        .cornerRadius(30)
        .padding(.trailing)
    }
}
