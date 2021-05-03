//
//  CustomDateFormatter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation


/// Describes a
enum CustomDateFormatter {
    /// A non-localized formatter using the provided template.
    static func DateFormatterWithDateFormat(template: String, useLowercasedAMPMSymbols: Bool = false) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = template

        // Note that Locale usually determines whether AM/PM symbols are upper/lowercase.
        // Capitalisation is standard in the US, but not in Australia.
        // I've done this for testing purposes, since test environments (including simulator)
        // use US locale by default.
        if useLowercasedAMPMSymbols {
            formatter.amSymbol = formatter.amSymbol?.lowercased()
            formatter.pmSymbol = formatter.pmSymbol?.lowercased()
        }

        return formatter
    }

    /// Formats `2021-08-02T18:08:14+0000` as `Mon, 2 August`
    static let dayFormatter = DateFormatterWithDateFormat(template: "E, d MMMM")

    /// Formats `2021-08-02T18:08:14+0000` as `18:08`
    static let timeFormatter24hour = DateFormatterWithDateFormat(template: "HH:mm")
    /// Formats `2021-08-02T18:08:14+0000` as `06:08 pm`
    static let timeFormatter12hour = DateFormatterWithDateFormat(template: "hh:mm a", useLowercasedAMPMSymbols: true)


    /// Formats `2021-08-02T18:08:14+0000` as `2021-08-02T18:08:14.000`
    static let rawDataFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        formatter.formatOptions.remove(.withTimeZone)
        return formatter
    }()

    /// Formats `2021-08-02T18:08:14+0000` as `Mon, 2 Aug`
    static let abbreviatedMonthFormatter: DateFormatter = DateFormatterWithDateFormat(template: "E, d MMM")
}
