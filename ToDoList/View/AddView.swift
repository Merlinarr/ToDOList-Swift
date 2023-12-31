//
//  AddView.swift
//  ToDoList
//
//  Created by Tansy Tan on 11/5/23.
//

import SwiftUI

struct AddView: View {
    @State var textFieldText: String = ""
    @EnvironmentObject var listViewModel:ListViewModal
    @Environment(\.presentationMode) var presentationMode
    
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    let color = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height:55)
                    .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                
                Button(action: saveItem, label: {
                    Text("save".uppercased())
                        .foregroundColor(.white)
                        .frame(height:55)
                        .frame(maxWidth:.infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                    
                })
            }.padding()
                
        }
        .navigationTitle("Add an item 👿")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    func saveItem(){
        if textValid() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }else{
            
        }
    }
    func textValid()->Bool{
        if textFieldText.count < 3 {
            alertTitle = "Must be at least 3 characters long 👻"
            showAlert.toggle()
            return false
        }
        return true
    }
    func getAlert( )-> Alert{
        return Alert(title:Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }.environmentObject(ListViewModal())
        
    }
}

