//
//  ValueExtractorTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 3/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class ValueExtractorTests: XCTestCase {

    private func test<T: Equatable>(valueExtractor: _ValueExtractor<T>, input: String, result expectedResult: T?, remainder expectedRemainder: String, file: StaticString = #filePath, line: UInt = #line) {
        let (value, actualRemainder) = valueExtractor.extractValue(from: input)
        expect(value, toEqual: expectedResult, file: file, line: line)
        expect(actualRemainder, toEqual: Substring(expectedRemainder), file: file, line: line)
    }

    func test_valueExtractor_callsProvidedBlock() {
        let valueExtractor = try! _ValueExtractor(pattern: "abc", extractValue: { return $0 })

        // Given an match, it returns the match and an empty string for the remainder
        let string1 = "abc"
        test(
            valueExtractor: valueExtractor,
            input: string1,
            result: "abc",
            remainder: ""
        )

        // Given an incomplete match, the remainder is the input text
        let string2 = "ab"
        test(
            valueExtractor: valueExtractor,
            input: string2,
            result: nil,
            remainder: "ab"
        )

        // Given a match at the end of the string, the remainder is an empty string
        let string3 = "xyzabc"
        test(
            valueExtractor: valueExtractor,
            input: string3,
            result: "abc",
            remainder: ""
        )

        // Given a match at the start of the string, the remainder the portion of the input that comes after the match
        let string5 = "abcxyz"
        test(
            valueExtractor: valueExtractor,
            input: string5,
            result: "abc",
            remainder: "xyz"
        )

        // Given a match in the middle of the string, the remainder is the portion of the input that comes after the match.
        let string4 = "xyzabc123"
        test(
            valueExtractor: valueExtractor,
            input: string4,
            result: "abc",
            remainder: "123"
        )
    }

    // MARK: - Provided Extractors

    // MARK: Hours

    func test_hoursExtractor() {
        // No "hr" = no result
        let string1 = "aldksf"
        test(
            valueExtractor: ValueExtractor.hours,
            input: string1,
            result: nil,
            remainder: string1
        )

        // "hr" with no number = no result
        let string2 = "skdfhr"
        test(
            valueExtractor: ValueExtractor.hours,
            input: string2,
            result: nil,
            remainder: string2
        )

        // "1hr" should match to 1
        let string3 = "skdf1hr"
        test(
            valueExtractor: ValueExtractor.hours,
            input: string3,
            result: 1,
            remainder: ""
        )

        // Should successfully match 2 digits
        let string4 = "skdf41hr"
        test(
            valueExtractor: ValueExtractor.hours,
            input: string4,
            result: 41,
            remainder: ""
        )

        // Should match no more than 2 digits, and return any following text
        let string5 = "skdf541hrafsd"
        test(
            valueExtractor: ValueExtractor.hours,
            input: string5,
            result: 41,
            remainder: "afsd"
        )
    }

    // MARK: Minutes

    func test_minutesExtractor_returnsNilWhenNoMinutes() {
        // No "min" = no result
        let string1 = "aldksf"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string1,
            result: nil,
            remainder: string1
        )

        // "min" with no number = no result
        let string2 = "skdfmin"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string2,
            result: nil,
            remainder: string2
        )

        // "1hr" should match to 1
        let string3 = "skdf1min"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string3,
            result: 1,
            remainder: ""
        )

        // Should successfully match 2 digits
        let string4 = "skdf41min"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string4,
            result: 41,
            remainder: ""
        )

        // Should match no more than 2 digits, and return any following text
        let string5 = "skdf541minafsd"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string5,
            result: 41,
            remainder: "afsd"
        )

        // Should match no more than 2 digits, and return any following text
        let string6 = "skdf12min523afsd"
        test(
            valueExtractor: ValueExtractor.minutes,
            input: string6,
            result: 12,
            remainder: "523afsd"
        )
    }
}
