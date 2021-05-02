//
//  TicketDataPresenter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation

/// Formats and presents flight data on the provided display.
struct TicketDataPresenter {
    weak var ticketDisplay: TicketDisplay?

    func present(flight: Flight) {
        let formatter = CustomDateFormatter.abbreviatedMonthFormatter
        let timeFormatter = CustomDateFormatter.timeFormatter12hour

        let ticketViewData = TicketViewData(
            airportsData: FlightAirportsViewData(
                departureAirport: flight.departureAirport,
                departureCity: StringParser.cityFromCityAndCountry(in: flight.departureCity),
                departureTime: timeFormatter.string(from: flight.departureDate),
                departureDate: formatter.string(from: flight.departureDate),
                arrivalAirport: flight.arrivalAirport,
                arrivalCity: StringParser.cityFromCityAndCountry(in: flight.arrivalCity),
                arrivalDate: formatter.string(from: flight.arrivalDate),
                arrivalTime: timeFormatter.string(from: flight.arrivalDate)
            ),
            flightNumber: flight.flightNumber
        )
        ticketDisplay?.configure(for: ticketViewData)
    }
}
