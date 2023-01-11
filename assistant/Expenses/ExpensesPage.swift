//
//  ExpensesPage.swift
//  assistant
//
//  Created by Leonid Semenov on 08.01.2023.
//

import SwiftUI
import CoreData

struct ExpensesPage: View {
    @FetchRequest private var firstExpenseRecord: FetchedResults<ExpenseModel>
    
    init() {
        let request: NSFetchRequest<ExpenseModel> = ExpenseModel.fetchRequest()
        request.fetchLimit = 1
        request.sortDescriptors = []
        _firstExpenseRecord = FetchRequest(fetchRequest: request)
    }
    
    func getFirstExpenseCreatedAt() -> Date {
        if (firstExpenseRecord.isEmpty) {
            return Date.now
        } else {
            return firstExpenseRecord[0].date ?? Date.now
        }
    }
    
    var body: some View {
        ExpensesView(firstExpenseCreatedAt: getFirstExpenseCreatedAt())
    }
}

struct ExpensesPage_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesPage()
    }
}
