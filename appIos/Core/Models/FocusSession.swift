//
//  FocusSession.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

struct FocusSession: Codable, Identifiable {
    let id: UUID
    let date: Date
    let durationInMinutes: Int
    let taskId: UUID?
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        durationInMinutes: Int,
        taskId: UUID? = nil
    ) {
        self.id = id
        self.date = date
        self.durationInMinutes = durationInMinutes
        self.taskId = taskId
    }
}
