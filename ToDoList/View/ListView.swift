//
//  ListView.swift
//  ToDoList
//
//  Created by Tansy Tan on 11/5/23.
//

import SwiftUI

struct ListView: View {

    @EnvironmentObject var listViewModal: ListViewModal
    
    var body: some View {
        ZStack {
            if listViewModal.items.isEmpty {
                NoItemsView()
            }else{
                List{
            
                    ForEach(listViewModal.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModal.updateStatus(updateItem: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModal.DeleteItem)
                    .onMove (perform: listViewModal.MoveItem)
                }
            }
        
         
        }   .listStyle(PlainListStyle())
            .navigationTitle("Todo List 🤪")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                        NavigationLink("Add", destination: AddView())
            )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModal())
    }
}
