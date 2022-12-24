//
//  ListItem.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 24.10.2022.
//

import SwiftUI

struct CheckItem: View {
    var todoModel: TodoModel
    @State private var isChecked: Bool
    
    init(todo: TodoModel) {
        todoModel = todo
        isChecked = todoModel.isDone
    }
    
    var body: some View {
        HStack {
            Text(todoModel.todoText)
            Spacer()
            ToggleButton(todoModel: todoModel, isChecked: $isChecked)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var todoModel = TodoModel.testData[0]
    
    static var previews: some View {
        CheckItem(todo: todoModel)
    }
}
