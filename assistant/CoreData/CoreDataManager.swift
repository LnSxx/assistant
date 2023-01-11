//
//  PersistantContainer.swift
//  assistant
//
//  Created by Leonid Semenov on 01.01.2023.
//

import Foundation
import CoreData

final class CoreDataManager: ObservableObject {
    @Published var container: NSPersistentContainer = getCoreDataPersistantContainer()
    @Published var expenses: [ExpenseModel] = [ExpenseModel]()
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

func getCoreDataPersistantContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "AssistantModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}

