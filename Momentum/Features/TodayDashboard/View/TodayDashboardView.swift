//
//  TodayDashboardView.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import SwiftUI

struct TodayDashboardView: View {
    @StateObject private var viewModel = TodayDashboardViewModel()
    @State private var showingAddTask = false
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header with stats
                    headerSection
                    
                    // Today's tasks section
                    todayTasksSection
                    
                    // Focus time section
                    focusTimeSection
                }
                .padding()
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                addTaskSheet
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Good morning!")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Let's make today productive")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            HStack(spacing: 20) {
                StatCard(
                    title: "Tasks Done",
                    value: "\(viewModel.completedTasksToday)/\(viewModel.todayTasks.count)",
                    color: .momentumAccentBlue
                )
                
                StatCard(
                    title: "Focus Time",
                    value: "\(viewModel.totalFocusTimeToday)m",
                    color: .momentumAccentOrange
                )
            }
        }
        .padding()
        .background(Color.momentumBoneBackground)
        .cornerRadius(16)
    }
    
    // MARK: - Today's Tasks Section
    
    private var todayTasksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Today's Tasks")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            if viewModel.todayTasks.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    
                    Text("No tasks for today")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Add a task to get started")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.todayTasks) { task in
                        TaskRow(
                            task: task,
                            onToggleCompletion: { viewModel.toggleTaskCompletion(task) },
                            onDelete: { viewModel.deleteTask(task) }
                        )
                    }
                }
            }
        }
    }
    
    // MARK: - Focus Time Section
    
    private var focusTimeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Focus Sessions")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Start Focus") {
                    viewModel.addFocusSession(durationInMinutes: 25) // Pomodoro timer
                }
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.momentumAccentBlue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            if viewModel.totalFocusTimeToday == 0 {
                VStack(spacing: 12) {
                    Image(systemName: "timer")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    
                    Text("No focus time today")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                Text("Total focus time today: \(viewModel.totalFocusTimeToday) minutes")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Add Task Sheet
    
    private var addTaskSheet: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Task title", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showingAddTask = false
                        newTaskTitle = ""
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(title: newTaskTitle)
                            showingAddTask = false
                            newTaskTitle = ""
                        }
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct TaskRow: View {
    let task: MomentumTask
    let onToggleCompletion: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(task.isCompleted ? .momentumAccentBlue : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.body)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
                
                if let notes = task.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            if task.isPriority {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundColor(.momentumAccentOrange)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) {
                onDelete()
            }
        }
    }
}

#Preview {
    TodayDashboardView()
}
