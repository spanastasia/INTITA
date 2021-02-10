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
                            title: "Do another",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .high,
                            state: .inWork,
                            createdDate: Date()))
        
        model.tasks.append(Task(
                            id: 3,
                            title: "Do smth else",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .completed,
                            createdDate: Date()))
        
        model.tasks.append(Task(
                            id: 4,
                            title: "Just do...",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .medium,
                            state: .waitingForTask,
                            createdDate: Date()))
        model.tasks.append(Task(
                            id: 5,
                            title: "Do, do and do...",
                            description: "",
                            author: "",
                            assignee: "",
                            watcher: "",
                            priority: .urgent,
                            state: .waitingForTask,
                            createdDate: Date()))
        return model
    }
}

//TODO: here should be model according this example
//{
//   "task":{
//      "id":1791,
//      "name":"...some text...",
//      "body":"...some text...",
//      "startTask":"2020-06-26 07:20:54",
//      "endTask":null,
//      "deadline":null,
//      "id_state":3,
//      "created_by":386,     //this is user id
//      "created_date":"2020-06-26 07:20:54",
//      "cancelled_by":null,
//      "cancelled_date":null,
//      "change_date":null,
//      "priority":2,
//      "id_parent":null,
//      "type":1,
//      "expected_time":null,
//      "changed_by":null,
//      "created_at":null,
//      "updated_at":null,
//      "typeName":"\u0417\u0430\u0432\u0434\u0430\u043d\u043d\u044f",
//      "task_state_history":[],
//      "children_tasks":[],
//      "attached_files":[],
//      "task_creator":{},   // here is a link for id at "created_by"
//      "task_assignee":{},
//      "task_watchers":[],
//      "task_collaborators":[],
//      "task_subgroup_collaborators":[],
//      "type_model":{}
//   },
//   "userTaskState":{},
//   "attachedFiles":[],
//   "roles":{}
//}

