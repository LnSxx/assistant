//
//  ExpenseIntervalSelector.swift
//  assistant
//
//  Created by Leonid Semenov on 06.01.2023.
//

import SwiftUI

struct ExpenseIntervalSelector: View {
    @ObservedObject var model: ExpensesModel
    
    var dateFormatted: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMMM YYYY"
        let selecetedInterval = model.intervals[model.selectedIntervalIndex]
        return dateFormatterGet.string(from: selecetedInterval.0)
    }
    
    var body: some View {
        Section {
            HStack() {
                Button {
                    model.moveBack()
                } label: {
                    Label("backward", systemImage: "chevron.backward")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.accentColor)
                }
                .disabled(model.isFirstIntervalSelected)
                Spacer()
                Text(dateFormatted)
                Spacer()
                Button {
                    model.moveForward()
                } label: {
                    Label("forward", systemImage: "chevron.forward")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.accentColor)
                }
                .disabled(model.isLastIntervalSelected)
            }
        }
    }
}

struct ExpenseIntervalSelector_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseIntervalSelector(model: ExpensesModel(firstExpenseCreatedAt: Date.now))
    }
}
