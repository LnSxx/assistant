//
//  dailychecklistApp.swift
//  dailychecklist
//
//  Created by Leonid Semenov on 24.10.2022.
//

import SwiftUI
import CoreData

@main
struct dailychecklistApp: App {
    @StateObject private var checklist = Checklist()
    @StateObject private var coreDataManager = CoreDataManager()
    @Environment(\.scenePhase) private var scenePhase
    
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
            TabView {
                СhecklistView().environmentObject(checklist)
                    .tabItem {
                        Label("Checklist", systemImage: "checklist")
                    }
                ExpensesPage()
                    .environmentObject(coreDataManager)
                    .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                    .tabItem {
                        Label("Expenses", systemImage: "chart.bar.xaxis")
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                coreDataManager.saveContext()
            @unknown default:
                print("unknown")
            }
        }
    }
}

