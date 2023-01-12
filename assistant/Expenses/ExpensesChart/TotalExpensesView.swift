//
//  TotalExpensesView.swift
//  assistant
//
//  Created by Leonid Semenov on 10.01.2023.
//

import SwiftUI

struct TotalExpensesView: View {
    let totalValue: Double
    var body: some View {
        HStack {
            Text("Total:")
            Spacer()
            Text(String(totalValue.getAmountFormatted()))
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
        }
    }
}

struct TotalExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        TotalExpensesView(
            totalValue: 1000
        )
    }
}
