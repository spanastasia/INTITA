//
//  MultipleSelectionViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

class MultipleSelectionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var coordinator: MultipleSelectionCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
    }
    
}
