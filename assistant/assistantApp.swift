//
//  dailychecklistApp.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 24.10.2022.
//

import SwiftUI

@main
struct dailychecklistApp: App {
    @StateObject private var checklist = Checklist()
    
    init() {
        checkLastVisit()
    }
    
    func checkLastVisit() {
        let lastVisitDate = getLastVisit()
        let days = Calendar.current.dateComponents([.hour], from: lastVisitDate, to: Date.now)
        if days.day != nil && days.day != 0 {
            let todos = loadListOfTodoFromUD()
            let todosUnchecked: [TodoModel] = todos.map {todoModel in
                todoModel.copyWith(isDone: false)
            }
            setListOfTodoToUD(todos: todosUnchecked.reversed())
        }
    }
    
    var body: some Scene {
        WindowGroup {
            СhecklistView().environmentObject(checklist)
        }
    }
}
