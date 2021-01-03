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
        State.allCases.count
    }
    
    func getCountOfTasks(in state: State) -> Int {
        getTasks(for: state).count
    }
    
    func getTitle(for state: State) -> String {
        state.description
    }
    
    func getTasks(for state: State) -> [Task] {    
        return tasksModel.tasks.filter { (task) in
            return task.state == state
        }
    }
    
    
}
