//
//  TaskCell.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 02.01.2021.
//

import UIKit

class TaskCell: UITableViewCell, NibCapable {

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
        case .low:
            taskPriority.textColor = .green // did not found an example on intita.com
        case .medium:
            taskPriority.textColor = UIColor.mediumPriorityColor
        case .high:
            taskPriority.textColor = UIColor.highPriorityColor
        case .urgent:
            taskPriority.textColor = UIColor.urgentPriorityColor

        }
    }
}
