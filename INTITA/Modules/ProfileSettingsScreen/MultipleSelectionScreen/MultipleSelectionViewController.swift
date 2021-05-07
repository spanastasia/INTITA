//
//  MultipleSelectionViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

enum Section {
    case first
}

struct ButtonItem: Hashable {
    var id: Int
    var title: String
    var enabled: Bool
    
    mutating func changedType() {
        self.enabled.toggle()
    }
}

class MultipleSelectionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var coordinator: MultipleSelectionCoordinator?
    var viewModel: MultipleSelectionViewModel!
    private var diffableDataSource: UITableViewDiffableDataSource<Section, ButtonItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDoneButton()
        setupCell()
        
        prepareDataSource()
        tableView.dataSource = diffableDataSource
        diffableDataSource?.defaultRowAnimation = .left
        tableView.delegate = self
        
        diffableDataSource?.apply(viewModel.prepareSnapshot(), animatingDifferences: false)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setupDoneButton() {
        doneButton.shadowed()
        doneButton.setTitle("done".localized, for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 24)
        doneButton.rounded(cornerRadius: 15.0)
    }
    
    private func setupCell() {
        tableView.register(ItemTableViewCell.nib(), forCellReuseIdentifier: ItemTableViewCell.identifier)
    }
    
    private func prepareDataSource() {
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item -> UITableViewCell? in
        
            return self.labelCellForRowAt(indexPath, with: item)
        }
    }
    
    private func labelCellForRowAt(_ indexPath: IndexPath, with item: ButtonItem) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as? ItemTableViewCell else {
                return UITableViewCell()
            }
        cell.configure(with: item)
        cell.backgroundColor = .systemGray6

        return cell
    }
    
}

extension MultipleSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setEnabletToItem(with: indexPath.row)
        diffableDataSource?.apply(viewModel.prepareSnapshot(), animatingDifferences: false)
    }
}
