//
//  TasksViewModel.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import Foundation

class TasksViewModel {
    var tasksModel: TasksModel = TasksModel.tempData
    
    var numberOfStates: Int {
        Task.State.allCases.count
    }
    
    func getCountOfTasks(in state: Task.State) -> Int {
        getTasks(for: state).count
    }
    
    func getTitle(for state: Task.State) -> String {
        state.description
    }
    
    func getTasks(for state: Task.State) -> [Task] {    
        return tasksModel.tasks.filter { (task) in
            return task.state == state
        }
    }
    
    
}
