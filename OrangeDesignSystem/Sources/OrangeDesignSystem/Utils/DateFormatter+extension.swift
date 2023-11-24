//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

extension DateFormatter {

    /// Returns a `String` version of the given `Date`localized for the most suitable language
    /// - Parameters:
    ///   - date: The `Date` to format
    ///   - bundle: The `Bundle` containing preferred localizations for which the first should be used if defined, if not `Locale.current`
    ///   - dateStyle: The date to apply for the format
    ///   - timeStyle: The style of the time of the date to deal with
    /// - Returns: The formatted `Date` as `String`
    static func localizedFormat(date: Date, for bundle: Bundle, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        var localeToUse: Locale
        if let firstPreferredLocalization = bundle.preferredLocalizations.first { // Select language in app language (supposed to be)
            localeToUse = Locale(identifier: firstPreferredLocalization)
        } else {
            localeToUse = Locale.current // System language
        }
        return format(date: date, for: localeToUse, dateStyle: dateStyle, timeStyle: timeStyle)
    }

    /// Formats the given `Date`as `String` with the given styles
    /// - Parameters:
    ///   - date: The `Date` to format
    ///   - locale: The `Locale` to use for format
    ///   - dateStyle: The date to apply for the format
    ///   - timeStyle: The style of the time of the date to deal with
    /// - Returns: The formatted `Date` as `String`
    static func format(date: Date, for locale: Locale, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle)
        return dateFormatter.string(from: date)
    }

    /// Creates if not yet done or just returns a `DateFormatter` using the given parameters.
    /// Because the initialization of such objects could be costly  the object once created is stored locally.
    /// - Parameters:
    ///  - locale: The locale to use to format some date
    ///  - dateStyle: The date to apply for the format
    ///  - timeStyle: The style of the time of the date to deal with
    /// - Returns: A freshly created new `DateFormatter` or another objected stored previsouly when created before
    static func formatter(for locale: Locale, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter {
        if let dateFormatter = DateFormatterCache.shared.formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle) {
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            DateFormatterCache.shared.store(formatter: dateFormatter, using: .localeDateTimeCache)
            return dateFormatter
        }
    }

    /// Creates if not yet done or just returns a `DateFormatter` using the given parameters.
    /// Because the initialization of such objects could be costly the object once created is stored locally.
    /// - Parameter dateFormat: The date format to apply to the date formatter
    /// - Returns: A freshly created new `DateFormatter` or another objected stored previsouly when created before
    static func formatter(for dateFormat: String) -> DateFormatter {
        if let dateFormatter = DateFormatterCache.shared.formatter(for: dateFormat) {
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            DateFormatterCache.shared.store(formatter: dateFormatter, using: .dateFormatCache)
            return dateFormatter
        }
    }
}
