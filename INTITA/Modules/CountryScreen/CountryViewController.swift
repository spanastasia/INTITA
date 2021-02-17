//
//  CountryViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

class CountryViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: CountryCoordinator?
    let countryList = LocationService<CountryModel>.locations
    var viewModel: CountryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
//        coordinator?.returnToProfileSettingsScreen()
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
    
}

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountry ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        let geocode = countryList?[indexPath.row].geocode
        cell.emojiLabel.text = flag(country: geocode ?? "EN")
        cell.nameCountryLabel.text = countryList?[indexPath.row].titleEN
        if let numberCountry = countryList?[indexPath.row].id {
            cell.numberCountryLabel.text = "+" + "\(String(numberCountry))"
        } else {
            cell.numberCountryLabel.text = "+1"
        }
        
        return  cell
    }
    
}
