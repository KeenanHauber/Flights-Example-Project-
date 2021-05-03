//
//  ValueExtractor.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 3/5/21.
//

import Foundation

enum ValueExtractor {
    /// Extracts hours from encoded flight duration data.
    static let hours = try! _ValueExtractor<Int>(pattern: "\\d{1,2}hr", extractValue: { Int($0.dropLast(2)) })
    /// Extracts minutes from encoded flight duration data.
    static let minutes = try! _ValueExtractor<Int>(pattern: "\\d{1,2}min", extractValue: { Int($0.dropLast(3)) })
}

/// Matches a pattern in a string and uses a provided block to extract a value.
struct _ValueExtractor<ValueType> {
    /// A regular expression to identify the range containing the value.
    let regex: NSRegularExpression
    /// Extracts a value from a substring from the matched range.
    private let _extractValue: (Substring) -> ValueType?

    init(pattern: String, extractValue: @escaping (Substring) -> ValueType?) throws {
        regex = try NSRegularExpression(pattern: pattern)
        self._extractValue = extractValue
    }

    /// Matches a value in the provided string using the provided pattern.
    func extractValue(from string: String) -> (value: ValueType?, remainder: Substring) {
        let range = NSRange(location: 0, length: string.utf16.count)
        guard let result = regex.firstMatch(in: string, range: range),
              let resultRange = Range(result.range, in: string) else {
            return (value: nil, remainder: Substring(string))
        }

        return (value: _extractValue(string[resultRange]), remainder: string[resultRange.upperBound...])
    }
}
