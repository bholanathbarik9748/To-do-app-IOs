//
//  TudoViewModel.swift
//  Tudo List Ios
//
//  Created by Bholanath Barik on 03/07/24.
//

import Foundation

class TudoViewModel : ObservableObject {
    @Published var tudos: [TodoModel] = []
    private let objectkey = "TudoList";
    
    init() {
        loadTudo();
    }
    
    private func saveTudo(){
        if let encodedData = try? JSONEncoder().encode(tudos) {
            UserDefaults.standard.setValue(encodedData, forKey: objectkey)
        }
    }
    
    private func loadTudo(){
        if let savedData = UserDefaults.standard.data(forKey: objectkey),
           let savedTudos = try? JSONDecoder().decode([TodoModel].self, from: savedData) {
            tudos = savedTudos
        }
    }
    
    func add(title: String) {
        let newTudo = TodoModel(id: UUID(), title: title, isCompleted: false);
        tudos.append(newTudo);
        saveTudo();
    }
    
    func deleteTudo(at offsets: IndexSet){
        tudos.remove(atOffsets: offsets);
        saveTudo();
    }
    
    func toggleComplete(for todo : TodoModel) {
        if let index = tudos.firstIndex(where: { $0.id == todo.id }) {
            tudos[index].isCompleted = true;
        }
    }
}
