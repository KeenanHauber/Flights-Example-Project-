//
//  JSONDownloadTaskService.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import Foundation

/// Provides an interface for downloading JSON files directly into a given decodable type.
protocol JSONDownloadTaskServing {
    /// Downloads and attempts to decode a JSON file from a given URL.
    func downloadJSON<ValueType: Decodable>(from url: URL, completionHandler: @escaping (Result<ValueType, Error>) -> Void)
}

/// Provides an interface for downloading JSON files directly into a given decodable type.
final class JSONDownloadTaskService: JSONDownloadTaskServing {

    /// Indicates a failure to download a resource from a given URL.
    struct DownloadError: Error {
        let url: URL
    }

    // MARK: - Lifecycle

    init(urlSession: URLSessionService) {
        self.session = urlSession
    }

    // MARK: - Dependencies

    /// Dependencies
    let session: URLSessionService

    /// The decoder used to decode JSON.
    let jsonDecoder = JSONDecoder()

    // MARK: - Downloading

    /// Downloads and attempts to decode a JSON file from a given URL.
    func downloadJSON<ValueType: Decodable>(from url: URL, completionHandler: @escaping (Result<ValueType, Error>) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in

            guard let self = self else { return }

            if let data = data {
                do {
                    let value = try self.jsonDecoder.decode(ValueType.self, from: data)
                    completionHandler(.success(value))
                } catch {
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.failure(DownloadError(url: url)))
            }
        })

        task.resume()
    }
}
