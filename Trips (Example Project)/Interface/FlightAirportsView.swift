//
//  FlightAirportsView.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import UIKit

class FlightAirportsView: UIView, NibLoadable {

    @IBOutlet weak var flightIconView: UIImageView!
    @IBOutlet weak var contentStackView: UIStackView!

    let departingAirportView = ScheduledAirportView.loadFromNib()
    let arrivingAirportView = ScheduledAirportView.loadFromNib()

    func loadedFromNib() {
        arrivingAirportView.leftAligned = false

        departingAirportView.backgroundColor = nil
        arrivingAirportView.backgroundColor = nil

        departingAirportView.setTextColor(to: .white)
        arrivingAirportView.setTextColor(to: .white)

        contentStackView.addArrangedSubview(departingAirportView)
        contentStackView.addArrangedSubview(arrivingAirportView)
    }
}
