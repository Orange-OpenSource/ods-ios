//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Because the instanciations of `DateFormatter` can be costly, helps to store such objects according to their configuration
final class DateFormatterCache {

    /// The cache of formatters depending to some configuration they must have
    private var cache: Cache<DateFormatterCache.Configuration, DateFormatter>

    /// The singleton
    static let shared = DateFormatterCache()

    private init() {
        cache = Cache<DateFormatterCache.Configuration, DateFormatter>()
    }

    struct Configuration: Hashable {
        let locale: Locale
        let dateStyle: DateFormatter.Style
        let timeStyle: DateFormatter.Style
    }

    /// - Returns: The `DateFormatter` which has the given arguments in configuration, or `nil` of none
    func formatter(for locale: Locale, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter? {
        cache[Configuration(locale: locale, dateStyle: dateStyle, timeStyle: timeStyle)]
    }

    /// Stores in the cahe the given `DateFormatter` and overrides the prvious value if it exists
    /// - Parameter formatter: The `DateFormatter` to store according to its locale, date style and time style
    func store(formatter: DateFormatter) {
        cache[Configuration(locale: formatter.locale,
                            dateStyle: formatter.dateStyle,
                            timeStyle: formatter.timeStyle)] = formatter
    }

    /// Deletes all the entries store din the cache
    func flush() {
        cache.removeAllValues()
    }
}
