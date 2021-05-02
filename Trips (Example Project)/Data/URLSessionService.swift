//
//  URLSessionService.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import Foundation

/// A wrapping protocol for `URLSession` to allow testing.
protocol URLSessionService {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionService {}
