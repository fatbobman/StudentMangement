//
//  ContentView.swift
//  StudentMangement
//
//  Created by Yang Xu on 2020/9/4.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var store:Store
    @State private var action:SheetAction?
    @FetchRequest(entity: Student.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: false)]) var students:FetchedResults<Student>
    var body: some View {
        NavigationView{
            List{
                ForEach(students){ student in
                    HStack{
                        Button(
                            action:{
                                action = .show(student: student)
                            }
                        ){
                        HStack{
                            Text(student.name ?? "")
                            if student.sex == 1 {
                                Text("男")
                            }
                            if student.sex == 2 {
                                Text("女")
                            }
                            Text(student.birthday ?? Date(),style: .date)
                        }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar{
                ToolbarItem(placement:ToolbarItemPlacement.navigationBarTrailing){
                    Button("New"){
                        action = .new
                    }
                }
            }
            .navigationTitle("Student List")
            .fullScreenCover(item: $action){ action in
                reducer(action: action)
            }
        }
    }
    
    private func reducer(action:SheetAction) -> some View{
        switch action{
        case .show(let student):
            return StudentManager(action:.show, student:student)
        case .new:
            return StudentManager(action: .new, student: nil)
        case .edit(let student):
            return StudentManager(action:.edit,student: student)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

enum SheetAction:Identifiable{
    case show(student:Student)
    case edit(student:Student)
    case new
    
    var id:UUID{UUID()}
}


