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

func setListOfTodoToUD(todos: [TodoModel]) {
    do {
        let encoder = JSONEncoder()
        let encodedTodo = try encoder.encode(todos)
        UserDefaults.standard.removeObject(forKey: TodoModel.udKey)
        UserDefaults.standard.set(encodedTodo, forKey: TodoModel.udKey)
        setLastVisit(date: Date.now)
    } catch {
        print("Unable to set TodoModel list (\(error))")
    }
}

func getLastVisit() -> Date {
    if let userDefaultsLastVisit = UserDefaults.standard.data(forKey: "LAST_VISIT") {
        do {
            let decoder = JSONDecoder()
            let lastVisit = try decoder.decode(Date.self, from: userDefaultsLastVisit)
            return lastVisit
        } catch {
            print("Unable to load last visit (\(error))")
        }
    }
    return Date.now
}

func setLastVisit(date: Date) {
    do {
        let encoder = JSONEncoder()
        let encodedDate = try encoder.encode(date)
        UserDefaults.standard.removeObject(forKey: "LAST_VISIT")
        UserDefaults.standard.set(encodedDate, forKey: "LAST_VISIT")
    } catch {
        print("Unable to set last visit (\(error))")
    }
}
