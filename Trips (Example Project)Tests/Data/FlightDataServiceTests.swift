//
//  FlightDataServiceTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class FlightDataServiceTests: XCTestCase {
    func test_withFlightData_usesProvidedURL() {
        let jsonService = DummyJSONDownloadTaskService(result: .failure(dummyError))

        let flightDataService1 = URLFlightDataService(targetURL: dummyURL, downloadService: jsonService)
        flightDataService1.withFlightData(do: { _ in })
        expect(jsonService.requestedURL, toEqual: dummyURL)

        let flightDataService2 = URLFlightDataService(targetURL: APIURL.flightList, downloadService: jsonService)
        flightDataService2.withFlightData(do: { _ in })
        expect(jsonService.requestedURL, toEqual: APIURL.flightList)
    }

    func test_withFlightData_providesError_whenServiceReturnsError() {
        let jsonService = DummyJSONDownloadTaskService(result: .failure(dummyError))

        let flightDataService = URLFlightDataService(targetURL: dummyURL, downloadService: jsonService)

        flightDataService.withFlightData(do: { result in
            switch result {
            case .failure(let error):
                self.expect(error as? TestError, toEqual: dummyError)
            case .success:
                XCTFail("Expected error!")
            }
        })
    }
}
