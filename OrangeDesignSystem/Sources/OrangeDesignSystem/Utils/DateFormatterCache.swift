//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Because the instanciations of `DateFormatter` can be costly, helps to store such objects according to their configuration
/// See https://sarunw.com/posts/how-expensive-is-dateformatter/
final class DateFormatterCache {

    // MARK: - Properties

    /// A cache of formatters depending to some configuration they must have (locale, date style and time style)
    private var localeDateTimeCache: Cache<DateFormatterCache.LocaleDateTimeConfiguration, DateFormatter>

    /// A cache of formatters depending to some configuration they must have (date format)
    private var dateFormatCache: Cache<DateFormatterCache.DateFormatConfiguration, DateFormatter>

    // MARK: - Singleton definition

    /// The singleton
    static let shared = DateFormatterCache()

    private init() {
        localeDateTimeCache = Cache<DateFormatterCache.LocaleDateTimeConfiguration, DateFormatter>()
        dateFormatCache = Cache<DateFormatterCache.DateFormatConfiguration, DateFormatter>()
    }

    // MARK: - Locale Date Time Configuration

    struct LocaleDateTimeConfiguration: Hashable {
        let locale: Locale
        let dateStyle: DateFormatter.Style
        let timeStyle: DateFormatter.Style
    }

    /// - Returns: The `DateFormatter` which has the given arguments in configuration, or `nil` of none
    func formatter(for locale: Locale, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter? {
        localeDateTimeCache[LocaleDateTimeConfiguration(locale: locale, dateStyle: dateStyle, timeStyle: timeStyle)]
    }

    // MARK: - Date Format Confguration

    struct DateFormatConfiguration: Hashable {
        let dateFormat: String
    }

    /// - Returns: The `DateFormatter` which has the given argument in configuration, or `nil` of none
    func formatter(for dateFormat: String) -> DateFormatter? {
        dateFormatCache[DateFormatConfiguration(dateFormat: dateFormat)]
    }

    // MARK: - Store

    /// To specifiy the type of cache the date formatters must be stored
    enum CacheType {
        case localeDateTimeCache
        case dateFormatCache
    }

    /// Stores in the cache the given `DateFormatter` and overrides the previous value if it exists
    /// - Parameters:
    ///    - formatter: The `DateFormatter` to store using the specified cache type
    ///    - cacheType: The type of cache to use defining the configuration of the date formatter as key
    func store(formatter: DateFormatter, using cacheType: CacheType) {
        switch cacheType {
        case .localeDateTimeCache:
            localeDateTimeCache[LocaleDateTimeConfiguration(locale: formatter.locale,
                                                            dateStyle: formatter.dateStyle,
                                                            timeStyle: formatter.timeStyle)] = formatter
        case .dateFormatCache:
            dateFormatCache[DateFormatConfiguration(dateFormat: formatter.dateFormat)] = formatter
        }
    }

    // MARK: - Flush

    /// Deletes all the entries stored in the caches
    func flush() {
        localeDateTimeCache.removeAllValues()
        dateFormatCache.removeAllValues()
    }
}
