//
//  CreateTodo.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 13.12.2022.
//

import SwiftUI

struct CreateCheck: View {
    @EnvironmentObject var model: Checklist
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var titleFieldIsFocused: Bool
    @State private var todo: String = ""
    
    
    var body: some View {
        List {
            Section {
                TextField(text: $todo) {
                    Text("")
                }
                .focused($titleFieldIsFocused)
                .disableAutocorrection(true)
            } header: {
                Text("What need to check?")
            }
        }.toolbar {
            Button {
                if !todo.isEmpty {
                    let newTodo = TodoModel(id: UUID().uuidString, todoText: todo, isDone: false)
                    model.addCheck(newTodo: newTodo)
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Save")
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
            }
            
        }
    }
}

struct CreateTodo_Previews: PreviewProvider {
    static var previews: some View {
        CreateCheck()
    }
}
