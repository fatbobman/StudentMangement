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
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}

class Store:ObservableObject{
    let context = PersistenceController.shared.container.viewContext
    
    func newStudent(viewModel:MyState) {
        let student = Student(context: context)
        student.name = viewModel.name
        student.sex = Int32(viewModel.sex)
        student.birthday = viewModel.birthday
        do{
            try context.save()
        }
        catch {print(error)}
    }
    
    func editStudent(viewModel:MyState,student:Student){
        student.name = viewModel.name
        student.birthday = viewModel.birthday
        student.sex = Int32(viewModel.sex)
        do{
            try context.save()
        }
        catch {print(error)}
    }
    
    func delStudent(student:Student){
         context.delete(student)
         try? context.save() 
    }
}
