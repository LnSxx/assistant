//
//  ExpensesListSection.swift
//  assistant
//
//  Created by Leonid Semenov on 09.01.2023.
//

import SwiftUI

struct ExpensesListSectionModel {
    let expenseItems: [ExpenseModel]
    let date: Date
}

struct ExpensesListSection: View {
    var expensesListSectionModel: ExpensesListSectionModel
    
    var body: some View {
        Section {
            ForEach(expensesListSectionModel.expenseItems) { expenseItem in
                ExpenseItem(expenseModel: expenseItem)
            }
        } header: {
            DateView(date: expensesListSectionModel.date)
        }
    }
}
