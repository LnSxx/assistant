//
//  ContentView.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 24.10.2022.
//

import SwiftUI

struct СhecklistView: View {
    @EnvironmentObject var model: Checklist
    @State private var showDeleteChecklistData = false
    
    private var checked:  [TodoModel]  {
        model.checklist.filter {$0.isDone}
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(model.checklist) { todo in
                            CheckItem(todo: todo)
                        }.onDelete(perform: model.delete)
                    } header: {
                        DateView(date: Date.now)
                    } footer: {
                        Text("\(checked.count)/\(model.checklist.count)")
                    }
                }
            }.navigationTitle("Daily checklist")
                .toolbar {
                    Button {
                        showDeleteChecklistData.toggle()
                    } label: {
                        Label("Remove", systemImage: "trash")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.secondary)
                    }
                    .confirmationDialog("Delete all checks?", isPresented: $showDeleteChecklistData, titleVisibility: .visible) {
                        Button("Clear checklist", role: .destructive) {
                            model.deleteAll()
                        }
                    }
                    NavigationLink {
                        CreateCheck()
                    } label: {
                        Label("Add check", systemImage: "plus.circle")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.accentColor)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        СhecklistView()
    }
}
