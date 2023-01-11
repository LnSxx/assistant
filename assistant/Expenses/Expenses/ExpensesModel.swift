//
//  ExpensesModel.swift
//  assistant
//
//  Created by Leonid Semenov on 05.01.2023.
//

import Foundation
import SwiftUI
import CoreData

class ExpensesModel: ObservableObject {
    @Published var intervals: [(Date, Date)]
    @Published var selectedIntervalIndex: Int
    
    var isFirstIntervalSelected: Bool {
        return selectedIntervalIndex == 0
    }
    
    var isLastIntervalSelected: Bool {
        return selectedIntervalIndex == intervals.count - 1
    }
    
    var selectedInterval: (Date, Date) {
        return intervals[selectedIntervalIndex]
    }

    
    init(firstExpenseCreatedAt: Date) {
        let listOfMonths = getListOfMonths(firstExpenseCreatedAt: firstExpenseCreatedAt)
        if listOfMonths.isEmpty {
            let currentMonthInterval: (Date, Date) = (Date.now.startOfCurrentMonth(),
                                                      Date.now.endOfCurrentMonth())
            self.intervals = [currentMonthInterval]
            self.selectedIntervalIndex = 0
        } else {
            self.intervals = listOfMonths
            self.selectedIntervalIndex = listOfMonths.count - 1
        }
    }
    
    
    private func setIntervalByIndex(index: Int) {
        selectedIntervalIndex = index
    }
    
    func moveBack() {
        if !self.isFirstIntervalSelected {
            self.setIntervalByIndex(
                index: self.selectedIntervalIndex - 1
            )
        }
    }
    
    func removeAllEntities(
        context: NSManagedObjectContext
    ) {
        let fetchRequest = ExpenseModel.fetchRequest()
        
        do {
            let entities = try context.fetch(fetchRequest)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        } catch {
            // Error Handling
        }
    }
    
    func moveForward() {
        if !self.isLastIntervalSelected {
            self.setIntervalByIndex(
                index: self.selectedIntervalIndex + 1
            )
        }
    }
}

func getListOfMonths(firstExpenseCreatedAt: Date) -> [(Date, Date)] {
    let dateNow = Date.now
    let diffComponents = Calendar.current.dateComponents([.month], from: firstExpenseCreatedAt, to: dateNow)
    let months = diffComponents.month
    if let monthsUnwrapped = months {
        if monthsUnwrapped == 0 {
            return [
                (Date.now.startOfCurrentMonth(),
                 Date.now.endOfCurrentMonth())
            ]
        } else {
            var resultList: [(Date, Date)] = []
            computeMonthIntervals(
                intervals: &resultList,
                addDate: dateNow.startOfCurrentMonth(),
                monthCount: monthsUnwrapped
            )
            return resultList
        }
    } else {
        return [
            (Date.now.startOfCurrentMonth(),
             Date.now.endOfCurrentMonth())
        ]
    }
}

func computeMonthIntervals(
    intervals: inout [(Date, Date)],
    addDate: Date,
    monthCount: Int
) {
    if intervals.count - 1 == monthCount {
        return
    } else {
        intervals.append(
            (
                addDate.startOfCurrentMonth(),
                addDate.endOfCurrentMonth()
            )
        )
        computeMonthIntervals(
            intervals: &intervals,
            addDate: Calendar.current.date(byAdding: DateComponents(month: 1), to: addDate)!,
            monthCount: monthCount
        )
    }
}

