//
//  FlightFormatter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// Maps flight objects to an instance of `FlightCellData`.
struct FlightToFlightCellDataMapper {
    /// The formatter used to convert dates to human-readable departure/arrival times.
    let timeFormatter: DateFormatter

    /// Returns `FlightCellData` instance describing the `Flight` instance.
    func flightCellData(from flight: Flight, withAssociatedAction associatedAction: @escaping () -> Void) -> FlightCellData {

        let arrivalCity = StringParser.cityFromCityAndCountry(in: flight.arrivalCity)

        return FlightCellData(
            title: "Flight to \(arrivalCity)",
            duration: "\(flight.scheduledDuration.hour) hr \(flight.scheduledDuration.minute) min",
            stopsDescription: "Non-Stop",
            departureCity: StringParser.cityFromCityAndCountry(in: flight.departureCity), departureCode: flight.departureAirport,
            departureTime: timeFormatter.string(from: flight.departureDate),
            arrivalCity: arrivalCity, arrivalCode: flight.arrivalAirport,
            arrivalTime: timeFormatter.string(from: flight.arrivalDate),
            performAssociatedAction: associatedAction
        )
    }
}
