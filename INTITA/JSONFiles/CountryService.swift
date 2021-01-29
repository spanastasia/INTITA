//
//  Countries.swift
//  INTITA
//
//  Created by Stepan Niemykin on 27.01.2021.
//

import Foundation

class CountryService {
    func getCountries() -> [CountryModel]? {
        var countries: [CountryModel]?
        guard let path = Bundle.main.url(forResource: "Countries", withExtension: "json") else { return nil}
        
        guard let json = try? Data(contentsOf: path) else { return nil}
        let decoder = JSONDecoder()
        
        do {
            countries = try decoder.decode([CountryModel].self, from: json)
        } catch {
            print(error.localizedDescription)
        }
        
        return countries
    }
}

