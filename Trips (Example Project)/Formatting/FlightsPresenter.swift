//
//  FlightsPresenter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// Formats flight data for a display.
struct FlightsPresenter {
    /// The display to present to.
    weak var flightsDisplay: FlightsDisplay?

    /// The formatter used to map flight objects to cell data objects
    let formatter: FlightToFlightCellDataMapper

    /// Formats and presents the flight information on the provided display, providing the associated callbacks.
    func present(flights: [Flight], actionForFlight: @escaping (Flight) -> (() -> Void)) {
        // TODO
        DispatchQueue.main.async {
            let sorted = flights.sorted(by: { $0.departureDate > $1.departureDate })
            let sections = TableViewTitledSection<Flight>.groupArrayIntoSections(sorted, titleForItem: { CustomDateFormatter.dayFormatter.string(from: $0.departureDate).uppercased()
            })
            let mapped = sections.map({ $0.mapRows({ flight in
                return formatter.flightCellData(
                    from: flight,
                    withAssociatedAction: actionForFlight(flight)
                )
            }) })
            flightsDisplay?.display(mapped)
        }
    }
}
