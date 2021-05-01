//
//  FlightDataService.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import Foundation

/// Provides an API for retrieving flight data from a given URL.
protocol FlightDataService {
    /// Provides a list of flights, or an error if the list could not be retrieved.
    func withFlightData(do: @escaping (Result<[Flight], Error>) -> Void)
}

/// Provides an API for retrieving flight data from a given URL.
struct URLFlightDataService: FlightDataService {

    /// The URL from which flight data will be retrieved.
    let targetURL: URL

    /// The service to which downloading the data is delegated.
    let downloadService: JSONDownloadTaskServing

    /// Provides a list of flights, or an error if the list could not be retrieved.
    func withFlightData(do block: @escaping (Result<[Flight], Error>) -> Void) {
        downloadService.downloadJSON(from: targetURL, completionHandler: { result in
            block(result)
        })
    }
}
