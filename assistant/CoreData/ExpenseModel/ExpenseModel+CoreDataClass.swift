//
//  ExpenseModel+CoreDataClass.swift
//  assistant
//
//  Created by Leonid Semenov on 01.01.2023.
//
//

import Foundation
import CoreData

@objc(ExpenseModel)
public class ExpenseModel: NSManagedObject {
    func getCategoryEnumValue() -> ExpenseCategory {
        return ExpenseCategory(rawValue: Int(self.category)) ?? .other
    }
}
