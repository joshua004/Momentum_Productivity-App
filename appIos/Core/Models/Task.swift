//
//  Task.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

struct MomentumTask: Codable, Identifiable {
    let id: UUID
    var title: String
    var notes: String?
    let creationDate: Date
    var dueDate: Date?
    var isCompleted: Bool
    var isPriority: Bool
    var estimatedTimeInMinutes: Int?
    
    init(
        id: UUID = UUID(),
        title: String,
        notes: String? = nil,
        creationDate: Date = Date(),
        dueDate: Date? = nil,
        isCompleted: Bool = false,
        isPriority: Bool = false,
        estimatedTimeInMinutes: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.creationDate = creationDate
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.isPriority = isPriority
        self.estimatedTimeInMinutes = estimatedTimeInMinutes
    }
}
