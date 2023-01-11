//
//  AddExpenseModel.swift
//  assistant
//
//  Created by Leonid Semenov on 03.01.2023.
//

import Foundation
import CoreData

class AddExpenseModel: ObservableObject {
    var nameFieldLimit: Int = 60
    var expenseCategories: [ExpenseCategory] = ExpenseCategory.allCases
    
    @Published var name: String = "" {
        didSet {
            if name.count > self.nameFieldLimit {
                name = String(name.prefix(nameFieldLimit))
            }
        }
    }
    @Published var amount: String = "";
    @Published var category: ExpenseCategory = .other
    
    var isFormValid: Bool {
        return !amount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && Double(self.amount) != nil
    }
    
    func resetState() {
        self.amount = ""
        self.category = .other
    }
    
    func addExpense(context: NSManagedObjectContext) {
        if isFormValid {
            let expenseModel = ExpenseModel(context: context)
            expenseModel.name = self.name
            expenseModel.amount = Double(self.amount)!
            expenseModel.date = Date.now
            expenseModel.id = UUID().uuidString
            expenseModel.category = Int64(category.rawValue)
            do {
                try context.save()
            }
            catch {
                // Handle Error
            }
        }
    }
}
