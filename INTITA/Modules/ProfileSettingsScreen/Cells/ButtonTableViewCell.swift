//
//  ButtonTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.04.2021.
//

import UIKit

protocol ButtonTableViewCellDelegate: AnyObject {
    func didTappedEducationField(_ sender: UITableViewCell, at index: Int, indexItem: Int)
}

class ButtonTableViewCell: UITableViewCell, NibCapable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    var itemType: CellType = .button
    var indexItem: Int?
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: LabelItem, with field: [String] = [], indexItem: Int? = nil) {
        titleLabel.text = item.title + ": "
        valueLabel.text = item.value
        
        isUserInteractionEnabled = true
        
        switch itemType {
        case .menu:
            self.indexItem = indexItem
            setupMenu(with: field)
        default:
            break
        }
    }
    
    func setupMenu(with field: [String]) {
        rightButton.menu = UIMenu(title: field.first?.localized ?? "",
                                  options: .displayInline,
                                  children: [
                                    UIAction(title: field[1].localized, handler: { action in
                                                self.delegate?.didTappedEducationField(self, at: 1, indexItem: self.indexItem ?? 0) }),
                                    UIAction(title: field[2].localized, handler: { action in
                                                self.delegate?.didTappedEducationField(self, at: 2,  indexItem: self.indexItem ?? 0) }),
                                    UIAction(title: "all_one".localized, handler: { action in
                                                self.delegate?.didTappedEducationField(self, at: 3, indexItem: self.indexItem ?? 0) })
                                  ])
        rightButton.showsMenuAsPrimaryAction = true
    }
}
