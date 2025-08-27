//
//  LoadCountiesVM.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Foundation

class LoadCountiesUtil {
    static func loadCountries() -> [Country] {
//        let paths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil)
//        print("JSON files in bundle:", paths)

        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            print("❌ countries.json not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            return countries
        } catch {
            print("❌ Error parsing countries.json: \(error)")
            return []
        }
    }
}
