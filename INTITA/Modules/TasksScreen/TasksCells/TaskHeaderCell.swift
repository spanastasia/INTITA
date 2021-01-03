//
//  TaskHeaderCell.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import UIKit

class TaskHeaderCell: UICollectionViewCell {

    @IBOutlet weak var titleOfTasks: UILabel!
    @IBOutlet weak var countOfTasks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func didMoveToWindow() {
        print(">>>\(titleOfTasks.text)")
    }
    
}
