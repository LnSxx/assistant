//
//  ExpensesSectionList.swift
//  assistant
//
//  Created by Leonid Semenov on 09.01.2023.
//

import SwiftUI

struct ExpensesSectionList: View {
    var expenses: [ExpenseModel]
    
    var grouped: [Date: [ExpenseModel]] {
        return groupedEpisodesByMonth(expenses)
    }
    
    var totalAmount: Double {
        return expenses.reduce(0, { a, b in
            a + b.amount
        })
    }
    
    var getExpensesByCategory: [Dictionary<ExpenseCategory, Double>.Element] {
        return getExpensesByCategories(expenses)
    }
    
    var amounts : [Double] {
        var result: [Double] = []
        for expenseByCategory in getExpensesByCategory {
            result.append(expenseByCategory.value)
        }
        return result
    }
    
    var categoryNames : [String] {
        var result: [String] = []
        for expenseByCategory in getExpensesByCategory {
            result.append(expenseByCategory.key.getName())
        }
        return result
    }
    
    var body: some View {
        ExpenseChartView(
            totalAmount: self.totalAmount,
            values: self.amounts,
            names: self.categoryNames
        )
        ForEach(grouped.sorted {
            $0.0 > $1.0
        }, id: \.key) { key, value in
            ExpensesListSection(expensesListSectionModel: ExpensesListSectionModel(expenseItems: value, date: key)
            )
        }
    }
}

func groupedEpisodesByMonth(_ expenses: [ExpenseModel]) -> [Date: [ExpenseModel]] {
    let empty: [Date: [ExpenseModel]] = [:]
    return expenses.reduce(into: empty) { acc, cur in
        let components = Calendar.current.dateComponents([.day], from: cur.date!)
        let date = Calendar.current.date(from: components)!
        let existing = acc[date] ?? []
        acc[date] = existing + [cur]
    }
}

struct CategoryExpense {
    var category: ExpenseCategory
    var amount: Double
    
    mutating func addToAmount(_ amount: Double) {
        self.amount += amount
    }
}

func getExpensesByCategories(_ expenses: [ExpenseModel]) -> [Dictionary<ExpenseCategory, Double>.Element] {
    var expensesByCategoriesDict : [ExpenseCategory: Double] = [
        ExpenseCategory.housing: 0,
        ExpenseCategory.transportation: 0,
        ExpenseCategory.utilities: 0,
        ExpenseCategory.healthcare: 0,
        ExpenseCategory.insurance: 0,
        ExpenseCategory.personal: 0,
        ExpenseCategory.dept: 0,
        ExpenseCategory.education: 0,
        ExpenseCategory.giftsDonations: 0,
        ExpenseCategory.entertainment: 0,
        ExpenseCategory.other: 0,
    ]
    
    for expense in expenses {
        expensesByCategoriesDict[expense.getCategoryEnumValue()]! += expense.amount
    }
    
    let sortedExpensesByCategoriesDict = expensesByCategoriesDict.sorted { (a, b) -> Bool in
        return a.value > b.value
    }
    
    let filteredExpensesByCategoriesDict = sortedExpensesByCategoriesDict.filter { expense in
        return expense.value > 0
    }
    
    return filteredExpensesByCategoriesDict
}
