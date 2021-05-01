//
//  Flight.swift
//  Trips (Example Project)
//
//  Created by Keenan Hauber on 1/5/21.
//

import Foundation

/// Describes the departure, arrival, and metadata of a flight scheduled by an airline.
struct Flight: Decodable {
    let id: Int

    let airlineCode: String
    let flightNumber: String
    let scheduledDuration: Duration

    let departureAirport: String
    let departureCity: String
    let departureDate: Date

    let arrivalAirport: String
    let arrivalCity: String
    let arrivalDate: Date

    init(id: Int,
        airlineCode: String,
        flightNumber: String,
        scheduledDuration: Duration,
        departureAirport: String,
        departureCity: String,
        departureDate: Date,
        arrivalAirport: String,
        arrivalCity: String,
        arrivalDate: Date) {
        self.id = id
        self.airlineCode = airlineCode
        self.flightNumber = flightNumber
        self.scheduledDuration = scheduledDuration
        self.departureAirport = departureAirport
        self.departureCity = departureCity
        self.departureDate = departureDate
        self.arrivalAirport = arrivalAirport
        self.arrivalCity = arrivalCity
        self.arrivalDate = arrivalDate
    }

    /// Indicates that a date could not be decoded from a string, because it was not in the expected format.
    struct UnrecognisedDateFormatError: Error {
        /// The string from which the date could not be extracted.
        let dateString: String
    }

    struct Duration: Equatable {
        let hour: Int
        let minute: Int
    }

    static let durationFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'hr'mm'min'"
        return formatter
    }()

    static let dateFormatter: ISO8601DateFormatter =  {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        formatter.formatOptions.remove(.withTimeZone)
        return formatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawDepartureDate = try container.decode(String.self, forKey: .departureDate)
        guard let departureDate = Self.dateFormatter.date(from: rawDepartureDate) else {
            throw UnrecognisedDateFormatError(dateString: rawDepartureDate)
        }

        let rawArrivalDate = try container.decode(String.self, forKey: .arrivalDate)
        guard let arrivalDate = Self.dateFormatter.date(from: rawArrivalDate) else {
            throw UnrecognisedDateFormatError(dateString: rawArrivalDate)
        }

        let rawDuration = try container.decode(String.self, forKey: .scheduledDuration)
        guard let durationAsDate = Self.durationFormatter.date(from: rawDuration) else {
            throw UnrecognisedDateFormatError(dateString: rawDuration)
        }
        let durationComponents = Calendar.current.dateComponents([.hour, .minute], from: durationAsDate)
        guard let hour = durationComponents.hour,
              let minute = durationComponents.minute else {
            throw UnrecognisedDateFormatError(dateString: rawDuration)
        }

        self.init(
            id: try container.decode(Int.self, forKey: .id),
            airlineCode: try container.decode(String.self, forKey: .airlineCode),
            flightNumber: try container.decode(String.self, forKey: .flightNumber),
            scheduledDuration: Duration(hour: hour, minute: minute),
            departureAirport: try container.decode(String.self, forKey: .departureAirport),
            departureCity: try container.decode(String.self, forKey: .departureCity),
            departureDate: departureDate,
            arrivalAirport: try container.decode(String.self, forKey: .arrivalAirport),
            arrivalCity: try container.decode(String.self, forKey: .arrivalCity),
            arrivalDate: arrivalDate
        )
    }

    enum CodingKeys: String, CodingKey {
        case id

        case airlineCode = "airline_code"
        case scheduledDuration = "scheduled_duration"
        case flightNumber = "flight_number"

        case departureDate = "departure_date"
        case departureCity = "departure_city"
        case departureAirport = "departure_airport"

        case arrivalCity = "arrival_city"
        case arrivalAirport = "arrival_airport"
        case arrivalDate = "arrival_date"
    }
}
