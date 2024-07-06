//
//  ContentView.swift
//  Tudo List Ios
//
//  Created by Bholanath Barik on 01/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TudoViewModel()
    @State private var tudoValue = "";
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Pls enter your to-do",text: $tudoValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.add(title: tudoValue)
                    tudoValue = "";
                }, label: {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .padding()
                
                List{
                    ForEach(viewModel.tudos) { tudo in
                        HStack {
                            Text(tudo.title)
                                .strikethrough(tudo.isCompleted , color: .green)
                                .foregroundStyle(tudo.isCompleted ? Color.green : Color.black)
                            
                            Spacer()
                            
                            if !tudo.isCompleted {
                                Button(action: {
                                    viewModel.toggleComplete(for: tudo)
                                }, label: {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                })
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteTudo(at: indexSet)
                    })
                }
            }
            .navigationBarTitle("To-Do List")
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
