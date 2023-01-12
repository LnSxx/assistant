//
//  ExpenseItem.swift
//  assistant
//
//  Created by Leonid Semenov on 03.01.2023.
//

import SwiftUI

struct ExpenseItem: View {
    let expenseModel: ExpenseModel
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(expenseModel.name ?? "")
                        .padding(.bottom, 1)
                    Text(expenseModel.getCategoryEnumValue().getName())
                        .font(.caption)
                        .foregroundColor(.primary).opacity(0.5)
                }
                Spacer()
                Text(expenseModel.amount.getAmountFormatted())
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.vertical, 1)
            
    }
}

extension Double {
    func getAmountFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.currencySymbol = ""
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
