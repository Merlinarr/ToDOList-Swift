//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Tansy Tan on 11/6/23.
//

import Foundation

class ListViewModal :ObservableObject{
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey :String = "items_list"
    init() {
        getItems()
    }
    func getItems(){
//        let newItems = [
//            ItemModel(title: "First Title", isCompleted: false),
//            ItemModel(title: "Second Title", isCompleted: true),
//            ItemModel(title: "Third Title", isCompleted: true),
//        ]
//        items.append(contentsOf: newItems)
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else{
            return
        }
       
        self.items = savedItems
    }
    func DeleteItem (_ indexSet:IndexSet)->Void {
        items.remove(atOffsets: indexSet)
    }
    func MoveItem (_ oldIdx:IndexSet,_ newIdx:Int)->Void {
        items.move(fromOffsets: oldIdx, toOffset: newIdx)
    }
    func addItem(title:String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    func updateStatus(updateItem:ItemModel){
        if let index = items.firstIndex (where:{ (existItem)->Bool in
            return existItem.id == updateItem.id
        }){
            items[index] = updateItem.updateCompletion()
        }
        //        updateItem.isCompleted = !updateItem.isCompleted
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
