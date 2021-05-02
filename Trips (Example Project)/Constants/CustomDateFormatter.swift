//
//  CustomDateFormatter.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 2/5/21.
//

import Foundation


/// Describes a
enum CustomDateFormatter {
    /// A formatter with autoupdating current locale that will use a localized format from the provided template.
    static func DateFormatterWithAutoupdatingLocale(template: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate(template)
        return formatter
    }

    /// Formats `2021-08-02T18:08:14+0000` as `Mon, 2 August`
    static let dayFormatter = DateFormatterWithAutoupdatingLocale(template: "E, d MMMM")

    /// Formats `2021-08-02T18:08:14+0000` as `18:08`
    static let timeFormatter24hour = DateFormatterWithAutoupdatingLocale(template: "HH:mm")
    /// Formats `2021-08-02T18:08:14+0000` as `06:08 pm`
    static let timeFormatter12hour = DateFormatterWithAutoupdatingLocale(template: "hh:mm a")


    /// Formats `2021-08-02T18:08:14+0000` as `2021-08-02T18:08:14.000`
    static let rawDataFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        formatter.formatOptions.remove(.withTimeZone)
        return formatter
    }()

    /// Formats `2021-08-02T18:08:14+0000` as `Mon, 2 Aug`
    static let abbreviatedMonthFormatter: DateFormatter = DateFormatterWithAutoupdatingLocale(template: "E, d MMM")
}
