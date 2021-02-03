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
    
    var viewModel = OpportunitiesViewModel()
    var coordinator: OpportunitiesCoordinator?
    var isProfileSize = true
    var tape: Opportunities?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNameLabel()
        setupAvailableOptionsLabel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupCell()

    }
    
    func setupCell() {
        tableView.register(OpportunitiesTableViewCell.nib(), forCellReuseIdentifier: OpportunitiesTableViewCell.identifier)
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
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Opportunities.allCases.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStates
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OpportunitiesTableViewCell.identifier, for: indexPath) as? OpportunitiesTableViewCell
        cell?.delegate = self
        
        switch indexPath.row {
        case 0:
            cell?.configureSmallView(with: Opportunities.course)
            cell?.type = .course
        case 1:
            cell?.configureSmallView(with: Opportunities.task)
            cell?.type = .task
        case 2:
            cell?.configureSmallView(with: Opportunities.study)
            cell?.type = .study

        default:
            break
        }
        
        return cell ?? UITableViewCell()
    }
    
}

extension OpportunitiesViewController: UITableViewDelegate {
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 75
//    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 28
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 28
//    }
}

extension OpportunitiesViewController: OpportunitiesTableViewCellDelegate {
    func downButtonTapped(sender: OpportunitiesTableViewCell, withType: Opportunities) {
//        print("withType")

        switch withType {
        case .course:
            sender.configureExtendedView(with: Opportunities.course)
        case .task:
            sender.configureExtendedView(with: Opportunities.task)
        case .study:
            sender.configureExtendedView(with: Opportunities.study)
        }
//        tableView.reloadData()
    }

}
