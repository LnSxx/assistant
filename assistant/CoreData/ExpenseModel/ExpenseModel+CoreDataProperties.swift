//
//  ExpenseModel+CoreDataProperties.swift
//  assistant
//
//  Created by Leonid Semenov on 01.01.2023.
//
//

import Foundation
import CoreData


extension ExpenseModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseModel> {
        return NSFetchRequest<ExpenseModel>(entityName: "ExpenseModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var category: Int64

}

extension ExpenseModel : Identifiable {
    
}
