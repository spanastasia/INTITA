//
//  CountryViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

protocol CountryViewControllerDelegate: AnyObject {
    func countryViewController(_ sender: UIViewController, didSelectCountry country: CountryModel)
}

class CountryViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: CountryViewControllerDelegate?
    var coordinator: CountryCoordinator?
    var viewModel: CountryViewModel?
    
    let countryList: [CountryModel]! = LocationService<CountryModel>.locations
    var searchArray: [CountryModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchArray = countryList
        
        titleLabel.text = "country_selection".localized
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

extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.countryViewController(self, didSelectCountry: searchArray[indexPath.row])
        
        dismiss(animated: true, completion: nil)
    }
}

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let geocode = searchArray[indexPath.row].geocode
        
        cell.imageView?.image = flag(country: geocode).emojiToImage()
        cell.textLabel?.text = searchArray[indexPath.row].titleEN
        
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

extension CountryViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        
        searchArray = countryList
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchArray = (searchText.isEmpty
                        ? countryList
                        : countryList.filter({ (model) -> Bool in
            return model.titleEN.range(of: searchText,
                                       options: .caseInsensitive,
                                       range: nil, locale: nil) != nil
        }))
        
        tableView.reloadData()
    }
}
