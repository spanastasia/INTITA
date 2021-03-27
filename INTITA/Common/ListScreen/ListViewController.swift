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
    
    lazy var listItems: [LocalizedResponseProtocol]! = []
    lazy var searchItems: [LocalizedResponseProtocol]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        listItems = viewModel.items
        searchItems = listItems
        
        titleLabel.text = viewModel.isGeocode(at: 0) == true
            ? "country_selection".localized
            : "city_selection".localized
    }
    
    func flag(country: String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append((UnicodeScalar(base + Int(i)) ?? UnicodeScalar.init(0)))
        }
        return String(usv)
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.listViewController(self, didSelectItem: searchItems[indexPath.row])

        dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if (viewModel?.isGeocode(at: indexPath.row)) == true {
            let geocode = viewModel?.getGeocode(at: indexPath.row)
            cell.imageView?.image = flag(country: geocode ?? "").emojiToImage()
        }

            cell.textLabel?.text = searchItems[indexPath.row].getLocalizedValue()
   
        if let _ = viewModel?.isAlreadySelected(at: indexPath.row) {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        return  cell
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
        searchBar.text = ""
        searchBar.endEditing(true)

//        searchItems = listItems
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchItems = (searchText.isEmpty
                        ? listItems
                        : listItems.filter({ (model) -> Bool in
                            return model.getLocalizedValue()?.range(of: searchText,
                                       options: .caseInsensitive,
                                       range: nil, locale: nil) != nil
        }))
        
        tableView.reloadData()
    }
}
