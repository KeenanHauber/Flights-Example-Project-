//
//  XCTestCase+extensions.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest

extension XCTestCase {
    /// Reports a fail if the provided optional is nil.
    func failIfAbsent<ValueType>(_ value: ValueType?, file: StaticString = #filePath, line: UInt = #line) {
        if value == nil {
            XCTFail("Value expected!", file: file, line: line)
        }
    }
}

