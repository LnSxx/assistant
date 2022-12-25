//
//  ContentView.swift
//  dailychecklist
//E
//  Created by Leonid Semenov on 24.10.2022.
//

import SwiftUI

struct СhecklistView: View {
    @EnvironmentObject var model: Checklist
    
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
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink {
                        CreateCheck()
                    } label: {
                        Label("Add check", systemImage: "square.and.pencil")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.accentColor)
                            .scenePadding(.bottom)
                            .scenePadding(.horizontal)
                    }
                }
            }.navigationTitle("Daily checklist")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        СhecklistView()
    }
}
