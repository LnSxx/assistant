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
        return groupedExpensesByDay(expenses)
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
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(.background)
        ForEach(grouped.sorted {
            $0.0 > $1.0
        }, id: \.key) { key, value in
            return ExpensesListSection(expensesListSectionModel: ExpensesListSectionModel(expenseItems: value, date: key)
            )
        }
    }
}

func groupedExpensesByDay(_ expenses: [ExpenseModel]) -> [Date: [ExpenseModel]] {
    var result: [Date: [ExpenseModel]] = [:]
    for expense in expenses {
        let expenseDay = Calendar.current.startOfDay(for: expense.date!)
        if result[expenseDay] != nil {
            var valueForDate = result[expenseDay]
            valueForDate!.append(expense)
            result[expenseDay] = valueForDate
        } else {
            result[expenseDay] = [expense]
        }
    }
    return result
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
