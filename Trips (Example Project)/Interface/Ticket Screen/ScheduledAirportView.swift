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

    /// Whether the contents are aligned to the left or right of the view.
    ///
    /// Default value is `false`.
    var leftAligned = false {
        didSet {
            contentStackView.alignment = leftAligned ? .leading : .trailing
        }
    }

    /// Styles a `ScheduledAirportView`.
    struct Style {
        /// Determines the style of `airportCodeLabel`
        let airportCodeLabelStyle: LabelStyle
        /// Determines the style of `cityNameLabel`
        let cityNameLabelStyle: LabelStyle
        /// Determines the style of `dateLabel`
        let dateLabelStyle: LabelStyle
        /// Determines the style of `timeLabel`
        let timeLabelStyle: LabelStyle
        /// Determines if the view's `dateLabel`'s `isHidden` property is set to true or false.
        let shouldShowDate: Bool

        /// The style used when nested in `FlightTableViewCell`.
        static let flightList = Style(
            airportCodeLabelStyle: .default,
            cityNameLabelStyle: .default,
            dateLabelStyle: .default,
            timeLabelStyle: .default,
            shouldShowDate: false
        )

        /// The style used when nested in `TicketView`.
        static let singleFlight = Style(
            airportCodeLabelStyle: .default,
            cityNameLabelStyle: .default,
            dateLabelStyle: .default,
            timeLabelStyle: .default,
            shouldShowDate: true
        )

        /// Applies the style to a cell.
        func apply(to cell: ScheduledAirportView, leftAlign: Bool) {
            cell.leftAligned = leftAlign
            cell.dateLabel.isHidden = !shouldShowDate

            airportCodeLabelStyle.apply(to: cell.airportCodeLabel)
            cityNameLabelStyle.apply(to: cell.cityNameLabel)
            dateLabelStyle.apply(to: cell.dateLabel)
            timeLabelStyle.apply(to: cell.timeLabel)
        }
    }
}
