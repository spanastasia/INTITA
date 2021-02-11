//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded, NibCapable {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var availableOptionsLabel: UILabel!

    var coordinator: OpportunitiesCoordinator?
    
    private var isProfileSize: [Bool] = Array(repeating: false, count: OpportunitiesType.allCases.count)

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNameLabel()
        setupAvailableOptionsLabel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupCell()

    }
    
    func setupCell() {
        tableView.register(OpportunitiesTableViewCell.nib(),
                           forCellReuseIdentifier: OpportunitiesTableViewCell.identifier)
    }
    
    func setupNameLabel() {
        nameLabel.text = "opportunities".localized
    }
    
    func setupAvailableOptionsLabel() {
        availableOptionsLabel.text = "available_options".localized
    }
    
    @IBAction func backButtonTappet(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    
}

extension OpportunitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OpportunitiesType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OpportunitiesTableViewCell.identifier, for: indexPath) as? OpportunitiesTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        cell.type = OpportunitiesType(rawValue: indexPath.row)
        cell.isProfileSize = isProfileSize[indexPath.row]
        
        return cell
    }
    
}

extension OpportunitiesViewController: UITableViewDelegate {

}

extension OpportunitiesViewController: OpportunitiesTableViewCellDelegate {
    func changeSizeCell(sender: OpportunitiesTableViewCell, index: OpportunitiesType.RawValue) {
        
        isProfileSize[index].toggle()
        
        tableView.performBatchUpdates {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
}
