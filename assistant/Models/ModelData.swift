//
//  ModelData.swift
//  Landmarks
//
//  Created by Leonid Semenov on 05.12.2022.
//

import Foundation
import Combine

final class Checklist: ObservableObject {
    @Published var checklist: [TodoModel] = loadListOfTodoFromUD().reversed()
    private let userDefaults = UserDefaults()
    
    func addCheck(newTodo: TodoModel) {
        self.checklist.insert(newTodo, at: 0)
        setListOfTodoToUD(todos: self.checklist.reversed())
    }
    
    func delete(at offsets: IndexSet) {
        self.checklist.remove(atOffsets: offsets)
        setListOfTodoToUD(todos: self.checklist.reversed())
    }
    
    func editTodo(editedTodo: TodoModel) {
        let todoList: [TodoModel] = self.checklist.map {todoModel in
            if todoModel.id == editedTodo.id {
                return editedTodo
            } else {
                return todoModel
            }
        }
        self.checklist = todoList
        setListOfTodoToUD(todos: todoList.reversed())
    }
    
    func toggleIsDoneInTodo(for todo: TodoModel) {
        editTodo(editedTodo: todo.copyWith(isDone: !todo.isDone))
    }
    
    func deleteAll() {
        self.checklist = []
        deleteAllFromUserDefaults()
    }
}

