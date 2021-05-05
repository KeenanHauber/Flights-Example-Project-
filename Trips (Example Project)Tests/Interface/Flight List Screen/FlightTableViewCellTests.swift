//
//  FlightTableViewCellTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 4/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class FlightTableViewCellTests: XCTestCase {

    func test() {
        let tableView = UITableView()

        // Register / Dequeue

        tableView.register(FlightTableViewCell.nib, forCellReuseIdentifier: FlightTableViewCell.reuseIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.reuseIdentifier) as? FlightTableViewCell else {
            XCTFail("Cell failed to dequeue!")
            return
        }

        // Outlets should be linked

        failIfAbsent(cell.destinationsStackView)
        failIfAbsent(cell.durationSummaryStackView)
        failIfAbsent(cell.titleLabel)
        failIfAbsent(cell.durationLabel)
        failIfAbsent(cell.stopsDescriptionLabel)

        // Awake from Nib should add subviews

        expect(cell.destinationsStackView.arrangedSubviews[0], toEqual: cell.departureAirportView)
        expect(cell.destinationsStackView.arrangedSubviews[1], toEqual: cell.arrivalAirportView)

        // configure should configure

        func testConfigure(title: String, duration: String, stopsDescription: String, departureCity: String, departureCode: String, departureTime: String, arrivalCity: String, arrivalCode: String, arrivalTime: String, performAssociatedAction: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
            cell.configure(for: FlightCellData(
                            title: title,
                            duration: duration,
                            stopsDescription: stopsDescription,
                            departureCity: departureCity,
                            departureCode: departureCode,
                            departureTime: departureTime,
                            arrivalCity: arrivalCity,
                            arrivalCode: arrivalCode,
                            arrivalTime: arrivalTime,
                            performAssociatedAction: performAssociatedAction
            ))

            expect(cell.titleLabel.text, toEqual: title)
            expect(cell.durationLabel.text, toEqual: duration)
            expect(cell.stopsDescriptionLabel.text, toEqual: stopsDescription)

            expect(cell.departureAirportView.cityNameLabel.text, toEqual: departureCity)
            expect(cell.departureAirportView.airportCodeLabel.text, toEqual: departureCode)
            expect(cell.departureAirportView.timeLabel.text, toEqual: departureTime)

            expect(cell.arrivalAirportView.cityNameLabel.text, toEqual: arrivalCity)
            expect(cell.arrivalAirportView.airportCodeLabel.text, toEqual: arrivalCode)
            expect(cell.arrivalAirportView.timeLabel.text, toEqual: arrivalTime)
        }

        var called1 = false
        testConfigure(
            title: "Test1",
            duration: "TestDuration1",
            stopsDescription: "TestDescription1",
            departureCity: "DepartureCity",
            departureCode: "DepartureCode",
            departureTime: "DepartureTime1",
            arrivalCity: "ArrivalCity1",
            arrivalCode: "ArrivalCode1",
            arrivalTime: "ArrivalTime1",
            performAssociatedAction: { called1 = true }
        )
        expect(called1, toEqual: false)

        var called2 = false
        testConfigure(
            title: "Test2",
            duration: "TestDuration2",
            stopsDescription: "TestDescription2",
            departureCity: "DepartureCit2",
            departureCode: "DepartureCod2",
            departureTime: "DepartureTime2",
            arrivalCity: "ArrivalCity2",
            arrivalCode: "ArrivalCode2",
            arrivalTime: "ArrivalTime2",
            performAssociatedAction: { called2 = true }
        )
        expect(called2, toEqual: false)

        // Test block

        var called3 = false
        let test = FlightCellData(
            title: "Test2",
            duration: "TestDuration2",
            stopsDescription: "TestDescription2",
            departureCity: "DepartureCit2",
            departureCode: "DepartureCod2",
            departureTime: "DepartureTime2",
            arrivalCity: "ArrivalCity2",
            arrivalCode: "ArrivalCode2",
            arrivalTime: "ArrivalTime2",
            performAssociatedAction: { called3 = true }
        )
        test.performAssociatedAction()
        expect(valueToBeTrue: called3)
    }
}
