//
//  ToggleButton.swift
//  assistant
//
//  Created by Leonid Semenov on 21.12.2022.
//

import SwiftUI

struct ToggleButton: View {
    @EnvironmentObject var model: Checklist
    let todoModel: TodoModel
    @Binding var isChecked: Bool
    
    var body: some View {
        Button {
            isChecked.toggle()
            model.toggleIsDoneInTodo(for: todoModel)
        } label: {
            Label("Check", systemImage: isChecked ? "checkmark.square.fill" : "checkmark.square")
                .labelStyle(.iconOnly)
                .foregroundColor(.accentColor)
        }
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var todoModel = TodoModel.testData[0]
    static var previews: some View {
        ToggleButton(todoModel: todoModel, isChecked: .constant(true))
    }
}
