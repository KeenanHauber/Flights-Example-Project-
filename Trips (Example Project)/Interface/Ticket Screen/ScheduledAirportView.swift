//
//  ScheduledAirportView.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import UIKit

class ScheduledAirportView: UIView, NibLoadable {

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var airportCodeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var leftAligned = false {
        didSet {
            contentStackView.alignment = leftAligned ? .leading : .trailing
        }
    }

    func setTextColor(to newColor: UIColor?) {
        dateLabel.textColor = newColor
        timeLabel.textColor = newColor
        cityNameLabel.textColor = newColor
        airportCodeLabel.textColor = newColor
    }
}
