//
//  TaskCell.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 02.01.2021.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskID: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var dateOfCreation: UILabel!
    @IBOutlet weak var taskPriority: UILabel!
    
    func configure (with task: Task) {
        taskID.text = String(task.id)
        taskTitle.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateOfCreation.text = formatter.string(from: task.createdDate)
        
        taskPriority.text = task.priority.description
        switch task.priority {
        case .medium:
            taskPriority.textColor = .orange
        case .high:
            taskPriority.textColor = .red // intita.com #da4d44
        case .urgent:
            taskPriority.textColor = .purple // intita.com #780823
        }
    }
}
