//
//  TodoModel.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 24.10.2022.
//

import Foundation

struct TodoModel: Hashable, Codable, Identifiable  {
    var id: String
    var todoText: String
    var isDone: Bool
    
    func copyWith(todoText: String? = nil, isDone: Bool? = nil) -> TodoModel {
        return TodoModel(
            id: self.id,
            todoText: todoText ?? self.todoText,
            isDone: isDone ?? self.isDone
        )
    }
}

extension TodoModel {
    static let testData: [TodoModel] = [
        TodoModel(id: UUID().uuidString, todoText: "Foo", isDone: false),
        TodoModel(id: UUID().uuidString, todoText: "Bar", isDone: false),
        TodoModel(id: UUID().uuidString, todoText: "Bar", isDone: false),
        TodoModel(id: UUID().uuidString, todoText: "Bar", isDone: false),
        TodoModel(id: UUID().uuidString, todoText: "Bar", isDone: false),
    ]
    
    static let udKey = "Todos"
}

func loadListOfTodoFromUD() -> [TodoModel] {
    if let userDefaultsTodos = UserDefaults.standard.data(forKey: TodoModel.udKey) {
        do {
            let decoder = JSONDecoder()
            let todos = try decoder.decode([TodoModel].self, from: userDefaultsTodos)
            return todos
        } catch {
            print("Unable to load TodoModel list (\(error))")
        }
    }
    return []
}

func setListOfTodoFromUD(todos: [TodoModel]) {
    do {
        let encoder = JSONEncoder()
        let encodedTodo = try encoder.encode(todos)
        UserDefaults.standard.removeObject(forKey: TodoModel.udKey)
        UserDefaults.standard.set(encodedTodo, forKey: TodoModel.udKey)
    } catch {
        print("Unable to set TodoModel list (\(error))")
    }
}

