//
//  CreateTodo.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 13.12.2022.
//

import SwiftUI

class CreateCheckModel: ObservableObject {
    var limit: Int = 60
    
    @Published var text: String = "" {
        didSet {
            if text.count > self.limit {
                text = String(text.prefix(limit))
            }
        }
    }
}

struct CreateCheck: View {
    @EnvironmentObject var model: Checklist
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var titleFieldIsFocused: Bool
    @ObservedObject private var createCheckModel = CreateCheckModel()
    
    
    var body: some View {
        List {
            Section {
                TextField(text: $createCheckModel.text) {
                    Text("")
                }
                .focused($titleFieldIsFocused)
                .disableAutocorrection(true)
            } header: {
                Text("What needs to be checked?")
            }
        }.toolbar {
            Button {
                if !createCheckModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    let newTodo = TodoModel(id: UUID().uuidString, todoText: createCheckModel.text.trimmingCharacters(in: .whitespacesAndNewlines), isDone: false)
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
