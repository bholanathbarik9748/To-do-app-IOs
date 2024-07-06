//
//  TudoViewModel.swift
//  Tudo List iOS
//
//  Created by Bholanath Barik on 03/07/24.
//

import Foundation

// ViewModel for managing a list of to-dos
class TudoViewModel: ObservableObject {
    @Published var tudos: [TodoModel] = []  // Published array to hold todo items
    private let objectKey = "TudoList"  // Key for saving/loading data from UserDefaults
    
    // Initializer to load saved todos when the view model is created
    init() {
        loadTudo()
    }
    
    // Function to save the current list of todos to UserDefaults
    private func saveTudo() {
        if let encodedData = try? JSONEncoder().encode(tudos) {
            UserDefaults.standard.setValue(encodedData, forKey: objectKey)
        }
    }
    
    // Function to load the list of todos from UserDefaults
    private func loadTudo() {
        if let savedData = UserDefaults.standard.data(forKey: objectKey),
           let savedTudos = try? JSONDecoder().decode([TodoModel].self, from: savedData) {
            tudos = savedTudos
        }
    }
    
    // Function to add a new todo item to the list
    func add(title: String) {
        let newTudo = TodoModel(id: UUID(), title: title, isCompleted: false)
        tudos.append(newTudo)
        saveTudo()
        loadTudo()
    }
    
    // Function to delete todo items from the list at specified offsets
    func deleteTudo(at offsets: IndexSet) {
        tudos.remove(atOffsets: offsets)
        saveTudo()
    }
    
    // Function to mark a todo item as completed
    func toggleComplete(for todo: TodoModel) {
        if let index = tudos.firstIndex(where: { $0.id == todo.id }) {
            tudos[index].isCompleted = true
        }
        saveTudo()
    }
}
