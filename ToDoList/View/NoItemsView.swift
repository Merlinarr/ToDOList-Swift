//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Tansy Tan on 11/6/23.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate:Bool = false
    let secondaryColor = Color("Secondary")
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                Text("There are no items!")
                    .font(.title )
                    .fontWeight(.semibold)
                Text("Add items to your todo list")
                    .padding(.bottom,20)
                
                
                
                NavigationLink(destination: AddView()) {
                    Text("Add Something🤗")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height:55)
                        .frame(maxWidth:.infinity)
                        .background(animate ? secondaryColor: Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal,animate ? 30 : 50)
                .shadow(color: animate ? secondaryColor.opacity(0.7):Color.accentColor.opacity(0.7), radius: 6, x: 0.0, y: 0.0)
                .scaleEffect(animate ? 1.1: 1.0)
            }
            .frame(maxWidth:400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear (perform: addAnimation)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        
    }
    func addAnimation(){
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation.easeInOut(duration: 2.0).repeatForever()
            ){
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemsView()
        }.navigationTitle("Add Something")
        
    }
}
