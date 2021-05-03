//
//  DateFormatterTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 3/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class CustomDateFormatterTests: XCTestCase {
    private var testDate: Date {
        let components = DateComponents(
            calendar: Calendar.autoupdatingCurrent,
            timeZone: .current,
            year: 2021,
            month: 8,
            day: 2,
            hour: 18,
            minute: 8,
            second: 14,
            nanosecond: 0
        )
        return components.date!
    }

    private func testToString(formatter: DateFormatter, expectedOutput: String, file: StaticString = #filePath, line: UInt = #line) {
        expect(formatter.string(from: testDate), toEqual: expectedOutput, file: file, line: line)
    }

    func test_useLowercasedAMPMSymbolsDeterminesCase() {
        testToString(
            formatter: CustomDateFormatter.DateFormatterWithDateFormat(template: "a", useLowercasedAMPMSymbols: false),
            expectedOutput: "PM"
        )
        testToString(
            formatter: CustomDateFormatter.DateFormatterWithDateFormat(template: "a", useLowercasedAMPMSymbols: true),
            expectedOutput: "pm"
        )
    }

    func test_formatters() {
        testToString(
            formatter: CustomDateFormatter.dayFormatter,
            expectedOutput: "Mon, 2 August"
        )
        testToString(
            formatter: CustomDateFormatter.timeFormatter24hour,
            expectedOutput: "18:08"
        )
        testToString(
            formatter: CustomDateFormatter.timeFormatter12hour,
            expectedOutput: "06:08 pm"
        )
        testToString(
            formatter: CustomDateFormatter.abbreviatedMonthFormatter,
            expectedOutput: "Mon, 2 Aug"
        )
    }

    func test_rawDataFormatter() {
        let dateString = "2021-08-02T18:08:14.020"
        let formatter = CustomDateFormatter.rawDataFormatter

        guard let date = formatter.date(from: dateString) else {
            XCTFail("Expected `date` to be a non-nil value.")
            return
        }
        expect(date, toEqualYear: 2021, month: 8, day: 2, hour: 18, minute: 8, second: 14, nanosecond: 20_000_000)

        expect(formatter.string(from: date), toEqual: dateString)
    }
}
