//
//  FlightCellData.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// Describes the data associated with a `FlightTableViewCell`.
struct FlightCellData: Actionable {
    /// The cell's title.
    let title: String

    /// The duration of the flight.
    let duration: String
    /// Describes how many stops the flight will make.
    let stopsDescription: String

    /// The city of departure.
    let departureCity: String
    /// The code of the departure airport.
    let departureCode: String
    /// The time of departure.
    let departureTime: String

    /// The city of arrival.
    let arrivalCity: String
    /// The code of the arrival airport.
    let arrivalCode: String
    /// The time of arrival.
    let arrivalTime: String

    /// An action to be performed when the cell is selected.
    let performAssociatedAction: () -> Void
}
