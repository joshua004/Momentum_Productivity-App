//
//  TodayDashboardViewModel.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation
import SwiftUI

@MainActor
class TodayDashboardViewModel: ObservableObject {
    @Published var tasks: [MomentumTask] = []
    @Published var focusSessions: [FocusSession] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let persistenceService: PersistenceServiceProtocol
    
    init(persistenceService: PersistenceServiceProtocol = LocalPersistenceService()) {
        self.persistenceService = persistenceService
        Task {
            await loadData()
        }
    }
    
    // MARK: - Public Methods
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let tasksResult = persistenceService.loadTasks()
            async let sessionsResult = persistenceService.loadFocusSessions()
            
            self.tasks = try await tasksResult
            self.focusSessions = try await sessionsResult
            
            self.isLoading = false
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    func addTask(title: String, notes: String? = nil, dueDate: Date? = nil, isPriority: Bool = false, estimatedTime: Int? = nil) {
        let newTask = MomentumTask(
            title: title,
            notes: notes,
            dueDate: dueDate,
            isPriority: isPriority,
            estimatedTimeInMinutes: estimatedTime
        )
        
        tasks.append(newTask)
        
        Task {
            do {
                try await persistenceService.saveTask(newTask)
            } catch {
                self.errorMessage = "Failed to save task: \(error.localizedDescription)"
            }
        }
    }
    
    func toggleTaskCompletion(_ task: MomentumTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        
        tasks[index].isCompleted.toggle()
        
        Task {
            do {
                try await persistenceService.saveTask(tasks[index])
            } catch {
                self.errorMessage = "Failed to update task: \(error.localizedDescription)"
            }
        }
    }
    
    func deleteTask(_ task: MomentumTask) {
        tasks.removeAll { $0.id == task.id }
        
        Task {
            do {
                try await persistenceService.deleteTask(with: task.id)
            } catch {
                self.errorMessage = "Failed to delete task: \(error.localizedDescription)"
            }
        }
    }
    
    func addFocusSession(durationInMinutes: Int, taskId: UUID? = nil) {
        let newSession = FocusSession(
            durationInMinutes: durationInMinutes,
            taskId: taskId
        )
        
        focusSessions.append(newSession)
        
        Task {
            do {
                try await persistenceService.saveFocusSession(newSession)
            } catch {
                self.errorMessage = "Failed to save focus session: \(error.localizedDescription)"
            }
        }
    }
    
    // MARK: - Computed Properties
    
    var todayTasks: [MomentumTask] {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        return tasks.filter { task in
            if let dueDate = task.dueDate {
                return dueDate >= today && dueDate < tomorrow
            }
            return Calendar.current.isDateInToday(task.creationDate)
        }
    }
    
    var completedTasksToday: Int {
        todayTasks.filter { $0.isCompleted }.count
    }
    
    var totalFocusTimeToday: Int {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        return focusSessions
            .filter { $0.date >= today && $0.date < tomorrow }
            .reduce(0) { $0 + $1.durationInMinutes }
    }
}
