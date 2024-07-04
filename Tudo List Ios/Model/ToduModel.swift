//
//  ToduModel.swift
//  Tudo List Ios
//
//  Created by Bholanath Barik on 03/07/24.
//

import Foundation

struct TodoModel: Identifiable, Encodable, Decodable {
    let id : UUID
    var title : String
    var isCompleted : Bool
    
    init(id: UUID, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
