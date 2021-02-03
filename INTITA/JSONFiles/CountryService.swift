//
//  Countries.swift
//  INTITA
//
//  Created by Stepan Niemykin on 27.01.2021.
//

import Foundation

class CountryService {
    static var countries: [CountryModel]? {
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
    
    static func countryBy(geocode: String) -> CountryModel? {
        
        let country = countries?.filter {
            $0.geocode == geocode
        }
        
        return country?.first
    }
}

