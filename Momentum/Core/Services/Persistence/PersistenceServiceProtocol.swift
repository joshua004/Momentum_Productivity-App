//
//  PersistenceServiceProtocol.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

protocol PersistenceServiceProtocol {
    // Task operations
    func saveTasks(_ tasks: [MomentumTask]) async throws
    func loadTasks() async throws -> [MomentumTask]
    func saveTask(_ task: MomentumTask) async throws
    func deleteTask(with id: UUID) async throws
    
    // Focus session operations
    func saveFocusSessions(_ sessions: [FocusSession]) async throws
    func loadFocusSessions() async throws -> [FocusSession]
    func saveFocusSession(_ session: FocusSession) async throws
    func deleteFocusSession(with id: UUID) async throws
}
