//
//  TaskModel.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 28.12.2020.
//

import Foundation

struct Task: Codable  {
    let id: Int
    var title: String
    var description: String
    var author: String
    var assignee: String
    var watcher: String
    var priority: Priority
    var state: State
    var createdDate: Date
}

enum Priority: String, Codable {
    case medium
    case high
    case urgent
    
    var description: String {
        switch self {
        case .medium:
            return "medium_priority".localized
        case .high:
            return "high_priority".localized
        case .urgent:
            return "urgent_priority".localized
        }
    }
}

enum State: Int, Codable, CaseIterable {
    case waitingForTask
    case inWork
    case paused
    case completed
    
    var description: String {
        switch self {
        case .waitingForTask:
            return "waiting_task".localized
        case .inWork:
            return "in_work".localized
        case .paused:
            return "paused".localized
        case .completed:
            return "completed".localized
        }
    }
}


struct TasksModel {
    var tasks: [Task]
}

extension TasksModel {
    static var tempData: TasksModel {
        var model = TasksModel(tasks: [])
        model.tasks.append(Task(
                            id: 1,
                            title: "Do smth",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .inWork,
                            createdDate: Date()))
        
        model.tasks.append(Task(
                            id: 2,
                            title: "Do smth",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .inWork,
                            createdDate: Date()))
        
        model.tasks.append(Task(
                            id: 3,
                            title: "Do smth",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .completed,
                            createdDate: Date()))
        
        model.tasks.append(Task(
                            id: 4,
                            title: "Do smth",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .waitingForTask,
                            createdDate: Date()))
        
        
        
        return model
    }
}
