//
//  StudentMangementApp.swift
//  StudentMangement
//
//  Created by Yang Xu on 2020/9/4.
//

import SwiftUI

@main
struct StudentMangementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
