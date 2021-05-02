//
//  APIURLTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class APIURLTests: XCTestCase {

    /// Ensures the presence of all API URLs.
    func test_apiURLS() {
        failIfAbsent(APIURL.flightList)
    }
}
