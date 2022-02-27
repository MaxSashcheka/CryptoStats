//
//  DateFormatter.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 27.02.22.
//

import Foundation

extension DateFormatter {
    static let infoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "MMM d"
        return formatter
    }()
}
