//
//  FlightsViewControllerTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 5/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class FlightsViewControllerTests: XCTestCase {
    func test_loadedView_providesDataSourceAndDelegate() {
        let viewController = FlightsViewController()
        _ = viewController.view

        // Outlets

        failIfAbsent(viewController.contentView)
    }

    func test_displayDoesNotCrashBeforeViewIsLoaded() {
        let viewController = FlightsViewController()
        viewController.display([])
    }

    func test_displayBeforeViewLoaded_providesContentAfterViewIsLoaded() {
        let viewController = FlightsViewController()

        var actionCalled = false

        viewController.display([
            TableViewTitledSection(
                title: "Test Section",
                rows: [
                    FlightCellData(
                        title: "titleTest1",
                        duration: "durationTest1",
                        stopsDescription: "stopsDescriptionTest1",
                        departureCity: "departureCityTest1",
                        departureCode: "departureCodeTest1",
                        departureTime: "departureTimeTest1",
                        arrivalCity: "arrivalCityTest1",
                        arrivalCode: "arrivalCodeTest1",
                        arrivalTime: "arrivalTimeTest1",
                        performAssociatedAction: { actionCalled =  true }
                    )
                ])
        ])

        _ = viewController.view
        expect(viewController.contentView.numberOfSections, toEqual: 1)
        expect(viewController.contentView.numberOfRows(inSection: 0), toEqual: 1)

        expect(viewController.contentView.dataSource, toBe: viewController.tableViewDataSource)
        guard let cell = viewController.tableViewDataSource.tableView(viewController.contentView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FlightTableViewCell else {
            XCTFail("Cell was not of the expected type!")
            return
        }
        expect(cell.titleLabel.text, toEqual: "titleTest1")
        expect(cell.durationLabel.text, toEqual: "durationTest1")

        expect(cell.departureAirportView.cityNameLabel.text, toEqual: "departureCityTest1")
        expect(cell.departureAirportView.airportCodeLabel.text, toEqual: "departureCodeTest1")
        expect(cell.departureAirportView.timeLabel.text, toEqual: "departureTimeTest1")

        expect(cell.arrivalAirportView.cityNameLabel.text, toEqual: "arrivalCityTest1")
        expect(cell.arrivalAirportView.airportCodeLabel.text, toEqual: "arrivalCodeTest1")
        expect(cell.arrivalAirportView.timeLabel.text, toEqual: "arrivalTimeTest1")

        expect(viewController.contentView.delegate, toBe: viewController.tableViewDelegate)
        viewController.tableViewDelegate.tableView(viewController.contentView, didSelectRowAt: IndexPath(row: 0, section: 0))
        expect(valueToBeTrue: actionCalled)
    }

    func test_displayAfterViewLoaded_providesContentAfterViewIsLoaded() {

        // Data

        var cellIndex = 0
        var calledCellIndex = 0
        func nextCellIndex() -> Int {
            let index = cellIndex
            cellIndex += 1
            return index
        }
        let data = (0..<3).map({ index in
            return TableViewTitledSection(
                title: "Test Section \(index)",
                rows: (0..<3).map({ (_: Int) -> FlightCellData in
                    let currentCellIndex = nextCellIndex()

                    return FlightCellData(
                        title: "titleTest\(currentCellIndex)",
                        duration: "durationTest\(currentCellIndex)",
                        stopsDescription: "stopsDescriptionTest\(currentCellIndex)",
                        departureCity: "departureCityTest\(currentCellIndex)",
                        departureCode: "departureCodeTest\(currentCellIndex)",
                        departureTime: "departureTimeTest\(currentCellIndex)",
                        arrivalCity: "arrivalCityTest\(currentCellIndex)",
                        arrivalCode: "arrivalCodeTest\(currentCellIndex)",
                        arrivalTime: "arrivalTimeTest\(currentCellIndex)",
                        performAssociatedAction: { calledCellIndex = currentCellIndex }
                    )
                })
            )
        })

        // ViewController

        let viewController = FlightsViewController()
        _ = viewController.view
        viewController.display(data)

        // Verify table view

        expect(viewController.contentView.numberOfSections, toEqual: data.count)
        expect(viewController.contentView.delegate, toBe: viewController.tableViewDelegate)
        expect(viewController.contentView.dataSource, toBe: viewController.tableViewDataSource)

        for sectionIndex in 0..<3 {
            expect(viewController.contentView.numberOfRows(inSection: sectionIndex), toEqual: data[sectionIndex].rows.count)

            for (rowIndex, _) in data[sectionIndex].rows.enumerated() {
                let _cell = viewController.tableViewDataSource.tableView(viewController.contentView, cellForRowAt: IndexPath(row: rowIndex, section: sectionIndex))
                guard let cell = _cell as? FlightTableViewCell else {
                    XCTFail("Cell was not of the expected type!")
                    return
                }

                let absoluteRowIndex = sectionIndex * 3 + rowIndex

                expect(cell.titleLabel.text, toEqual: "titleTest\(absoluteRowIndex)")
                expect(cell.durationLabel.text, toEqual: "durationTest\(absoluteRowIndex)")

                expect(cell.departureAirportView.cityNameLabel.text, toEqual: "departureCityTest\(absoluteRowIndex)")
                expect(cell.departureAirportView.airportCodeLabel.text, toEqual: "departureCodeTest\(absoluteRowIndex)")
                expect(cell.departureAirportView.timeLabel.text, toEqual: "departureTimeTest\(absoluteRowIndex)")

                expect(cell.arrivalAirportView.cityNameLabel.text, toEqual: "arrivalCityTest\(absoluteRowIndex)")
                expect(cell.arrivalAirportView.airportCodeLabel.text, toEqual: "arrivalCodeTest\(absoluteRowIndex)")
                expect(cell.arrivalAirportView.timeLabel.text, toEqual: "arrivalTimeTest\(absoluteRowIndex)")

                viewController.tableViewDelegate.tableView(viewController.contentView, didSelectRowAt: IndexPath(row: rowIndex, section: sectionIndex))

                expect(calledCellIndex, toEqual: absoluteRowIndex)
            }
        }
    }
}
