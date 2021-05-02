//
//  StringParser.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

enum StringParser {
    /// Takes a comma-separated city and country and returns the city.
    ///
    /// e.g. `Brisbane, Australia` becomes `Brisbane`
    static func cityFromCityAndCountry(in string: String) -> String {
        return String(string.prefix(while: { $0 != "," }))
    }
}
