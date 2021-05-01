//
//  TestObjects.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import Foundation
@testable import Trips__Example_Project_

// MARK: - Values

let dummyError = TestError()
/// A fake URL.
///
/// Points to the home directory because it can.
let dummyURL = URL(string: "~/")!

// MARK: - Dummies

/// An dummy error for test purposes.
struct TestError: Error, Equatable {}

/// Tracks whether `resume()` has been called.
class URLSessionDataTaskMock: URLSessionDataTask {
    var resumed = false
    override func resume() {
        resumed = true
    }
}

/// Returns provides a fake data task for testing purposes.
class DummyURLSession: URLSessionService {

    var dataTaskCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil
    let dataTaskMock = URLSessionDataTaskMock()

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCompletionHandler = completionHandler

        return dataTaskMock
    }
}

/// Provides the result specified in the initialiser, for testing purposes.
final class DummyJSONDownloadTaskService: JSONDownloadTaskServing {

    init(result: Result<Any, Error>) {
        self.result = result
    }
    var requestedURL: URL?
    let result: Result<Any, Error>

    func downloadJSON<ValueType>(from url: URL, completionHandler: @escaping (Result<ValueType, Error>) -> Void) where ValueType : Decodable {
        requestedURL = url
        completionHandler(result.map({ $0 as! ValueType }))
    }
}
