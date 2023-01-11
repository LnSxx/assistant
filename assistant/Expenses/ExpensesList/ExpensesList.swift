//
//  ExpensesList.swift
//  assistant
//
//  Created by Leonid Semenov on 06.01.2023.
//

import SwiftUI
import CoreData

struct ExpensesList: View {
    @FetchRequest private var expenses: FetchedResults<ExpenseModel>
    
    init(selectedInterval: (Date, Date)) {
        _expenses = FetchRequest(
            sortDescriptors: [SortDescriptor(\.date, order: .reverse)],
            predicate: NSPredicate(
                format: "(date >= %@) AND (date <= %@)", selectedInterval.0 as NSDate , selectedInterval.1 as NSDate
            )
        )
    }
    
    func getExpensesList() -> [ExpenseModel] {
        if expenses.isEmpty {
            return []
        } else {
            var unwrapped: [ExpenseModel] = []
            for expense in expenses {
                unwrapped.append(expense)
            }
            return unwrapped
        }
    }
    
    var body: some View {
        ExpensesSectionList(expenses: getExpensesList())
    }
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesList(selectedInterval: (Date.now, Date.now))
    }
}



