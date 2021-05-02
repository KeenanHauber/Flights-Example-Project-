//
//  FlightTableViewCell.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import UIKit

final class FlightTableViewCell: DequeueableConfigurableTableViewCell, NibLoadable {
    @IBOutlet weak var destinationsStackView: UIStackView!
    @IBOutlet weak var durationSummaryStackView: UIStackView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var stopsDescriptionLabel: UILabel!

    let departureAirportView = ScheduledAirportView.loadFromNib()
    let arrivalAirportView = ScheduledAirportView.loadFromNib()

    override func awakeFromNib() {
        ScheduledAirportView.Style.flightList.apply(to: departureAirportView, leftAlign: true)
        ScheduledAirportView.Style.flightList.apply(to: arrivalAirportView, leftAlign: false)

        destinationsStackView.addArrangedSubview(departureAirportView)
        destinationsStackView.addArrangedSubview(arrivalAirportView)

        durationSummaryStackView.leadingAnchor.constraint(greaterThanOrEqualTo: departureAirportView.trailingAnchor, constant: 8).isActive = true
        durationSummaryStackView.trailingAnchor.constraint(lessThanOrEqualTo: arrivalAirportView.leadingAnchor, constant: 8).isActive = true
    }

    func configure(for value: FlightCellData) {
        departureAirportView.airportCodeLabel.text = value.departureCode
        departureAirportView.timeLabel.text = value.departureTime
        departureAirportView.cityNameLabel.text = value.departureCity

        arrivalAirportView.airportCodeLabel.text = value.arrivalCode
        arrivalAirportView.timeLabel.text = value.arrivalTime
        arrivalAirportView.cityNameLabel.text = value.arrivalCity

        stopsDescriptionLabel.text = value.stopsDescription
        durationLabel.text = value.duration
        titleLabel.text = value.title
    }
}
