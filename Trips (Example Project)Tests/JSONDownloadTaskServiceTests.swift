//
//  JSONDownloadTaskServiceTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class JSONDownloadTaskServiceTests: XCTestCase {
    func test_downloadJSON_correctlyHandlesData() throws {
        let urlSession = DummyURLSession()
        let jsonService = JSONDownloadTaskService(urlSession: urlSession)

        let encoder = JSONEncoder()
        let testValue = 5
        let testData = try encoder.encode(testValue)

        jsonService.downloadJSON(from: dummyURL) { (result: Result<Int, Error>) in
            guard case let .success(value) = result,
                  value == testValue else {
                XCTFail()
                return
            }
        }
        guard let dataTaskCompletionHandler = urlSession.dataTaskCompletionHandler else {
            XCTFail()
            return
        }

        dataTaskCompletionHandler(testData, nil, nil)
    }

    func test_downloadJSON_errorsOnIncompatibleData() throws {
        let urlSession = DummyURLSession()
        let jsonService = JSONDownloadTaskService(urlSession: urlSession)

        let encoder = JSONEncoder()
        let testValue = "Hello"
        let testData = try encoder.encode(testValue)

        jsonService.downloadJSON(from: dummyURL) { (result: Result<Int, Error>) in
            guard case .failure = result else {
                XCTFail()
                return
            }
        }
        guard let dataTaskCompletionHandler = urlSession.dataTaskCompletionHandler else {
            XCTFail()
            return
        }

        dataTaskCompletionHandler(testData, nil, nil)
    }

    func test_downloadJSON_errorsOnError() throws {
        let urlSession = DummyURLSession()
        let jsonService = JSONDownloadTaskService(urlSession: urlSession)

        jsonService.downloadJSON(from: dummyURL) { (result: Result<Int, Error>) in
            guard case .failure = result else {
                XCTFail()
                return
            }
        }
        guard let dataTaskCompletionHandler = urlSession.dataTaskCompletionHandler else {
            XCTFail()
            return
        }

        dataTaskCompletionHandler(nil, nil, dummyError)
    }
}
