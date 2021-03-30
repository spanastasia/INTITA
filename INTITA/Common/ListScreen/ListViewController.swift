//
//  CountryViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func listViewController(_ sender: UIViewController, didSelectItem: LocalizedResponseProtocol)
}

class ListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ListViewControllerDelegate?
    var coordinator: ListCoordinator?
    var viewModel: ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        titleLabel.text = viewModel.isItemType()
            ? "country_selection".localized
            : "city_selection".localized
        
        viewModel.subscribe { _ in
            DispatchQueue.main.async {
                self.stopSpinner()
                self.tableView.reloadData()
            }
        }
        
        startSpinner()
        viewModel.fetchCountries()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.listViewController(self, didSelectItem: viewModel.searchItems[indexPath.row])

        dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.imageView?.image = viewModel.searchItems[indexPath.row].icon
        cell.textLabel?.text = viewModel.searchItems[indexPath.row].getLocalizedValue()
        
        if let _ = viewModel?.isAlreadySelected(at: indexPath.row) {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        }
    }
    
}

extension String {
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetFilter()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterItems(by: searchText)
    }
}
