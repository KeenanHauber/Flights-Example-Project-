//
//  FlightTests.swift
//  Trips (Example Project)Tests
//
//  Created by Keenan Hauber on 1/5/21.
//

import XCTest
@testable import Trips__Example_Project_

final class FlightTests: XCTestCase {

    func test_decodeFlights_whenDataIsValid_matchesProvidedData() throws {

        let decoder = JSONDecoder()

        let flights = try decoder.decode([Flight].self, from: data(forResource: "TestFlightData", ofType: ".json"))

        expect(flights.count, toEqual: 2)


        let flight1 = flights[0]
        expect(flight1.id, toEqual: 1)
        expect(flight1.airlineCode, toEqual: "AA")
        expect(flight1.flightNumber, toEqual: "6036")
        expect(flight1.scheduledDuration, toEqual: Flight.Duration(hour: 2, minute: 39))

        expect(flight1.departureAirport, toEqual: "PDX")
        expect(flight1.departureCity, toEqual: "Portland, United States")
        expect(flight1.departureDate, toEqualYear: 2019, month: 11, day: 15, hour: 06, minute: 5, second: 0, nanosecond: 0)

        expect(flight1.arrivalAirport, toEqual: "LAX")
        expect(flight1.arrivalCity, toEqual: "Los Angeles, United States")
        expect(flight1.arrivalDate, toEqualYear: 2019, month: 11, day: 15, hour: 08, minute: 44, second: 0, nanosecond: 0)


        let flight2 = flights[1]
        expect(flight2.id, toEqual: 2)
        expect(flight2.airlineCode, toEqual: "AS")
        expect(flight2.flightNumber, toEqual: "480")
        expect(flight2.scheduledDuration, toEqual: Flight.Duration(hour: 0, minute: 5))

        expect(flight2.departureAirport, toEqual: "PDX")
        expect(flight2.departureCity, toEqual: "Portland, United States")
        expect(flight2.departureDate, toEqualYear: 2019, month: 12, day: 2, hour: 21, minute: 20, second: 0, nanosecond: 0)

        expect(flight2.arrivalAirport, toEqual: "JFK")
        expect(flight2.arrivalCity, toEqual: "New York, United States")
        expect(flight2.arrivalDate, toEqualYear: 2019, month: 12, day: 3, hour: 5, minute: 25, second: 0, nanosecond: 0)
    }
}
