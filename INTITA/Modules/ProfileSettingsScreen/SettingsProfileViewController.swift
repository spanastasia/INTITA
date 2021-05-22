//
//  SettingsProfileViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

enum CellType {
    case button
    case textView
    case menu
    case inEnable
}

enum Sections {
    case first
}

class SettingsProfileViewController: UIViewController, Storyboarded {
    
    var coordinator: SettingsProfileCoordinator?
    var viewModel: SettingsProfileViewModel!
    
    private lazy var headerContentView: HeaderSettingsTableViewCell = .fromNib()
    private var dataSource: UITableViewDiffableDataSource<Sections, LabelItem>?
    
    private var type: CellType = .inEnable
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderTableView()
        setupHeaderView()
        registerCell()
        
        prepareDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
        dataSource?.defaultRowAnimation = .left
        
        viewModel.subscribe { error in
            if let error = error {
                print(error)
                return
            }
            self.dataSource?.apply(self.viewModel.prepareSnapshot(), animatingDifferences: false)
        }
        
        dataSource?.apply(viewModel.prepareSnapshot(), animatingDifferences: false)
    }
    
    private func setupHeaderTableView() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        header.backgroundColor = .systemGray6
        
        let label = UILabel(frame: CGRect(x: 28, y: 8, width: view.frame.width - 16, height: 20))
        label.text = "system_profile".localized
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    
    private func setupHeaderView() {
        headerContentView.delegate = self
        headerContentView.frame.size.width = view.frame.width
        headerView.addSubview(headerContentView)
    }
    
    private func prepareDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item -> UITableViewCell? in
            if self.viewModel.isProfileEditing {
                switch self.viewModel.getTypeEditingCell(with: indexPath.row) {
                case .button, .menu:
                    self.type = .button
//                case .menu:
//                    self.type = .menu
                default:
                    self.type = .textView
                }
            } else {
                self.type = .inEnable
            }
        
            return self.labelCellForRowAt(indexPath, with: item, with: self.type)
        }
    }
    
    func registerCell() {
        tableView.register(LabelTableViewCell.nib(),
                           forCellReuseIdentifier: LabelTableViewCell.identifier)
        
        tableView.register(TextViewTableViewCell.nib(),
                           forCellReuseIdentifier: TextViewTableViewCell.identifier)
        
        tableView.register(ButtonTableViewCell.nib(),
                           forCellReuseIdentifier: ButtonTableViewCell.identifier)
    }
    
    private func labelCellForRowAt(_ indexPath: IndexPath, with item: LabelItem, with type: CellType) -> UITableViewCell {
        var cell = UITableViewCell()
        switch type {
        case .inEnable:
            guard let labelCell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier) as? LabelTableViewCell else {
                return UITableViewCell()
            }
            labelCell.configure(with: item)
            labelCell.isItemEditing = viewModel.isEnableItem(with: indexPath.row)
            cell = labelCell
        case .button:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier) as? ButtonTableViewCell else {
                return UITableViewCell()
            }
            buttonCell.configure(with: item)
//            buttonCell.isItemEditing = viewModel.isEnableItem(with: indexPath.row)
            cell = buttonCell
        default:
            guard let textViewCell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.identifier) as? TextViewTableViewCell else {
                return UITableViewCell()
            }
            textViewCell.delegate = self
            textViewCell.configure(with: item)
            cell = textViewCell
        }
//        print(indexPath.row, viewModel.isEnableItem(with: indexPath.row))
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .white : .systemGray6
        return cell
    }
}

extension SettingsProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch EditingField(rawValue: indexPath.row) {
        case .city, .country:
            if viewModel.isProfileEditing {
                viewModel.isItemRow(row: indexPath.row)
                coordinator?.showListScreen()
            }
        case .birthday:
            if viewModel.isProfileEditing {
                coordinator?.showBirthdayScreen()
            }
        case .facebook, .twitter, .linkedin:
            guard let stringURL = viewModel.getValue(at: indexPath.row) else { return }
            if let url = URL(string: stringURL) {
                coordinator?.showSafari(with: url)
            }
        case .preferedSpecializations:
            if viewModel.isProfileEditing {
            viewModel.isItemRow(row: indexPath.row)
            coordinator?.showMultipleSelectionScreen()
            }
//        case .educationShift, .educform:
//            coordinator?.returnToProfileScreen()
        default:
            break
        }
    }
}

extension SettingsProfileViewController: HeaderSettingsTableViewCellDelegate {
    
    func goToProfileScreen() {
        coordinator?.returnToProfileScreen()
    }
    
    func editTapped(_ sender: HeaderSettingsTableViewCell) {
        viewModel.startEditUser()
        sender.setupEditBtn(isTrue: viewModel.isProfileEditing)
        
        if !viewModel.isProfileEditing {
            viewModel.putEditingUser()
        }
    }
}

extension SettingsProfileViewController: TextViewTableViewCellDelegate {
    func textViewTableViewCell(_ sender: TextViewTableViewCell, didChangeText text: String) {
        viewModel.setNewValueToTextView(from: sender.index, from: text)
    }
}
