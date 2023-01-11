//
//  AddExpense.swift
//  assistant
//
//  Created by Leonid Semenov on 28.12.2022.
//

import SwiftUI
import CoreData

struct AddExpense: View {
    @FocusState private var nameFieldIsFocused: Bool
    @FocusState private var amountFieldIsFocused: Bool
    @ObservedObject private var addExpenseModel = AddExpenseModel()
    @EnvironmentObject var coreDataManger: CoreDataManager
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField(text: $addExpenseModel.name) {
                        Text("")
                    }
                    .focused($nameFieldIsFocused)
                    .disableAutocorrection(true)
                    .submitLabel(.next)
                    .onSubmit {
                        nameFieldIsFocused.toggle()
                        amountFieldIsFocused.toggle()
                    }
                } header: {
                    Text("Name")
                }
                Section {
                    TextField(text: $addExpenseModel.amount) {
                        Text("")
                    }
                    .focused($amountFieldIsFocused)
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()

                                            Button("Done") {
                                                amountFieldIsFocused.toggle()
                                            }
                                        }
                                    }
                } header: {
                    Text("Amount")
                }
                Section {
                    Picker("Please choose a category", selection: $addExpenseModel.category) {
                        ForEach($addExpenseModel.expenseCategories, id: \.self) {
                            Text($0.wrappedValue.getName())
                        }
                    }
                } header: {
                    Text("Category of expense")
                }
            }.navigationTitle("Add expense")
                .toolbar {
                    Button {
                        addExpenseModel.resetState()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.accentColor).opacity(0.5)
                            .fontWeight(.regular)
                    }
                    Button {
                        addExpenseModel.addExpense(context: viewContext)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Add")
                            .foregroundColor(.accentColor)
                            .fontWeight(.semibold)
                    }
                }
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense()
    }
}
