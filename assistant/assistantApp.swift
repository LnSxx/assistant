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
    
    var body: some Scene {
        WindowGroup {
            СhecklistView().environmentObject(checklist)
        }
    }
}
