//
//  ExpenseChartView.swift
//  assistant
//
//  Created by Leonid Semenov on 10.01.2023.
//

import SwiftUI

struct ExpenseChartView: View {
    var totalAmount: Double
    var values: [Double]
    var names: [String]
    
    var body: some View {
        VStack {
            TotalExpensesView(totalValue: totalAmount)
            PieChart(
                values: values
            )
            .frame(
                width: 200,
                height: 215
            )
            .scaledToFit()
            PieChartLegend(values: values, names: names)
            .padding(.bottom)
        }
    }
}

struct ExpenseChartView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseChartView(
            totalAmount: 1000,
            values: [1, 1],
            names: ["Education", "Debt"]
        )
    }
}
