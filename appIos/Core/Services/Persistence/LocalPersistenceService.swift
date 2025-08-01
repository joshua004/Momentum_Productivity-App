//
//  LocalPersistenceService.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

class LocalPersistenceService: PersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let tasksKey = "momentum_tasks"
    private let focusSessionsKey = "momentum_focus_sessions"
    
    // MARK: - Task Operations
    
    func saveTasks(_ tasks: [MomentumTask]) async throws {
        let data = try JSONEncoder().encode(tasks)
        userDefaults.set(data, forKey: tasksKey)
    }
    
    func loadTasks() async throws -> [MomentumTask] {
        guard let data = userDefaults.data(forKey: tasksKey) else {
            return []
        }
        return try JSONDecoder().decode([MomentumTask].self, from: data)
    }
    
    func saveTask(_ task: MomentumTask) async throws {
        var tasks = try await loadTasks()
        
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        } else {
            tasks.append(task)
        }
        
        try await saveTasks(tasks)
    }
    
    func deleteTask(with id: UUID) async throws {
        var tasks = try await loadTasks()
        tasks.removeAll { $0.id == id }
        try await saveTasks(tasks)
    }
    
    // MARK: - Focus Session Operations
    
    func saveFocusSessions(_ sessions: [FocusSession]) async throws {
        let data = try JSONEncoder().encode(sessions)
        userDefaults.set(data, forKey: focusSessionsKey)
    }
    
    func loadFocusSessions() async throws -> [FocusSession] {
        guard let data = userDefaults.data(forKey: focusSessionsKey) else {
            return []
        }
        return try JSONDecoder().decode([FocusSession].self, from: data)
    }
    
    func saveFocusSession(_ session: FocusSession) async throws {
        var sessions = try await loadFocusSessions()
        
        if let index = sessions.firstIndex(where: { $0.id == session.id }) {
            sessions[index] = session
        } else {
            sessions.append(session)
        }
        
        try await saveFocusSessions(sessions)
    }
    
    func deleteFocusSession(with id: UUID) async throws {
        var sessions = try await loadFocusSessions()
        sessions.removeAll { $0.id == id }
        try await saveFocusSessions(sessions)
    }
}
