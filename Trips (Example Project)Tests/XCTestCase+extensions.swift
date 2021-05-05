//
//  XCTestCase+extensions.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest

extension XCTestCase {

    // Loading Test Assets

    func data(forResource resource: String, ofType type: String, file: StaticString = #file, line: UInt = #line) throws -> Data {
        return try Data(contentsOf: url(forResource: resource, ofType: type))
    }

    func url(forResource resource: String, ofType type: String, file: StaticString = #file, line: UInt = #line) -> URL {
        // It doesn't matter what test class we use here, so long as it's one we provide in the tests bundle.
        let testBundle = Bundle(for: FlightTests.self)
        guard let resourceURL = testBundle.url(forResource: resource, withExtension: type) else {
            fatalError("Failed to load resource \(resource) in bundle \(testBundle)!", file: file, line: line)
        }

        return resourceURL
    }

    // Testing

    /// Fails if the provided optional is nil.
    func failIfAbsent<ValueType>(_ value: ValueType?, file: StaticString = #filePath, line: UInt = #line) {
        if value == nil {
            XCTFail("Value expected!", file: file, line: line)
        }
    }

    /// Compares a given date against a date constructed from the given arguments.
    func expect(_ date: Date, toEqualYear year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, file: StaticString = #filePath, line: UInt = #line) {
        let dateComponents = DateComponents(
            calendar: .current,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second,
            nanosecond: nanosecond
        )
        print(dateComponents)

        expect(date, toEqual: dateComponents.date, file: file, line: line)
    }

    /// Fails if the provided values are not equal.
    func expect<ValueType: Equatable>(_ value1: ValueType, toEqual value2: ValueType, file: StaticString = #filePath, line: UInt = #line) {
        if value1 != value2 {
            XCTFail("\(value1) is not equal to \(value2)!", file: file, line: line)
        }
    }

    /// Fails if the provided value is false.
    func expect(valueToBeTrue boolean: Bool, file: StaticString = #filePath, line: UInt = #line) {
        if !boolean {
            XCTFail("Expected condition to be true", file: file, line: line)
        }
    }

    /// Fails if the provided values are not equal.
    func expect<ValueType: Equatable>(_ value1: ValueType?, toEqual value2: ValueType, file: StaticString = #filePath, line: UInt = #line) {
        if value1 != value2 {
            XCTFail("\(String(describing: value1)) is not equal to \(value2)!", file: file, line: line)
        }
    }
}

