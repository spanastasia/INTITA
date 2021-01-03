//
//  TaskCell.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 02.01.2021.
//

import UIKit

class TaskCell: UICollectionViewCell {

    @IBOutlet weak var taskID: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var dateOfCreation: UILabel!
    @IBOutlet weak var taskPriority: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure (with task: Task) {
        taskID.text = String(task.id)
        taskTitle.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateOfCreation.text = formatter.string(from: task.createdDate)
        
        taskPriority.text = task.priority.description
    }

}
