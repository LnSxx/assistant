//
//  ExpensesChartLegend.swift
//  assistant
//
//  Created by Leonid Semenov on 10.01.2023.
//

import SwiftUI

struct PieChartLegendCategoryValue: Identifiable {
    let id: UUID = UUID()
    var name: String
    var amount: Double
    var color: Color
}

struct PieChartLegend: View {
    let values: [Double]
    let names: [String]
    let colors: [Color] = chartColors
    
    var legendItems: [PieChartLegendCategoryValue] {
        var result: [PieChartLegendCategoryValue] = []
        for (index, name) in names.enumerated() {
            result.append(
                PieChartLegendCategoryValue(
                    name: name,
                    amount: values[index],
                    color: self.colors[index % colors.count]
                )
            )
        }
        return result
    }
    
    var body: some View {
        if !legendItems.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(legendItems) { legendItem in
                        PieChartLegendItem(data: legendItem)
                    }
                }
            }
        }
    }
}

