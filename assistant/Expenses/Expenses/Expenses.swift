//
//  Budget.swift
//  assistant
//
//  Created by Leonid Semenov on 27.12.2022.
//

import SwiftUI
import CoreData

struct ExpensesView: View {
    @State private var showingAddExpenseBottomsheet = false
    @State private var showDeleteChecklistData = false
    @ObservedObject var model: ExpensesModel;
    @Environment(\.managedObjectContext) private var viewContext
    
    init(firstExpenseCreatedAt: Date) {
        self.model = ExpensesModel(firstExpenseCreatedAt: firstExpenseCreatedAt)
    }
    
    var body: some View {
        NavigationView {
            List {
                ExpenseIntervalSelector(model: model)
                ExpensesList(selectedInterval: model.selectedInterval)
            }
            .navigationTitle("Expenses")
                .toolbar {
                    Button {
                        showDeleteChecklistData.toggle()
                    } label: {
                        Label("Remove", systemImage: "trash")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.secondary)
                    }
                    .confirmationDialog("Delete all expenses data?", isPresented: $showDeleteChecklistData, titleVisibility: .visible) {
                        Button("Clear expenses", role: .destructive) {
                            model.removeAllEntities(context: viewContext)
                        }
                    }
                    Button() {
                        showingAddExpenseBottomsheet.toggle()
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.accentColor)
                    }
                    .sheet(isPresented: $showingAddExpenseBottomsheet) {
                        AddExpense()
                            .presentationDetents([.large])
                    }
                }
            
        }
    }
}

struct Budget_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(firstExpenseCreatedAt: Date.now)
    }
}

extension Date {
    func startOfCurrentMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfCurrentMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfCurrentMonth())!
    }
}

