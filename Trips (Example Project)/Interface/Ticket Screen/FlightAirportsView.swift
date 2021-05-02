//
//  FlightAirportsView.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import UIKit

/// Describes the data associated with a `FlightAirportsView`.
struct FlightAirportsViewData {
    /// The code of the departure airport.
    let departureAirport: String
    /// The city of departure.
    let departureCity: String
    /// The time of departure.
    let departureTime: String
    /// The day of departure.
    let departureDate: String

    /// The code of the arrival airport.
    let arrivalAirport: String
    /// The city of arrival.
    let arrivalCity: String
    /// The day of arrival.
    let arrivalDate: String
    /// The time of arrival.
    let arrivalTime: String
}

/// Displays information about the departure and arrival airports of a flight.
final class FlightAirportsView: UIView, NibLoadable {

    @IBOutlet weak var flightIconView: UIImageView!
    @IBOutlet weak var contentStackView: UIStackView!

    let departingAirportView = ScheduledAirportView.loadFromNib()
    let arrivingAirportView = ScheduledAirportView.loadFromNib()

    func loadedFromNib() {

        departingAirportView.backgroundColor = nil
        arrivingAirportView.backgroundColor = nil

        ScheduledAirportView.Style.singleFlight.apply(to: departingAirportView, leftAlign: true)
        ScheduledAirportView.Style.singleFlight.apply(to: arrivingAirportView, leftAlign: false)

        contentStackView.addArrangedSubview(departingAirportView)
        contentStackView.addArrangedSubview(arrivingAirportView)
    }

    /// Sets the information displayed in the view.
    func configure(for data: FlightAirportsViewData) {
        departingAirportView.airportCodeLabel.text = data.departureAirport
        departingAirportView.cityNameLabel.text = data.departureCity
        departingAirportView.dateLabel.text = data.departureDate
        departingAirportView.timeLabel.text = data.departureTime

        arrivingAirportView.airportCodeLabel.text = data.arrivalAirport
        arrivingAirportView.cityNameLabel.text = data.arrivalCity
        arrivingAirportView.dateLabel.text = data.arrivalDate
        arrivingAirportView.timeLabel.text = data.arrivalTime
    }
}
