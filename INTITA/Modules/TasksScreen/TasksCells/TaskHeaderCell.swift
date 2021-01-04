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
        titleOfTasks.font = UIFont(name: "MyriadPro-Regular", size: 24.0)
        countOfTasks.rounded(cornerRadius: countOfTasks.frame.height/2, roundOnlyBottomCorners: false)
    }
    func configure (title: String, count: Int){
        titleOfTasks.text = title
        if count == 0 {
            countOfTasks.text = ""
        } else{
        countOfTasks.text = "\(count)"
            countOfTasks.backgroundColor = UIColor.primaryColor
        }
    }
}
