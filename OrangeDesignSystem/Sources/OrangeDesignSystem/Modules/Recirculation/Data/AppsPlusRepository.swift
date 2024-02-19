//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
// 
// This software is distributed under the MIT licence,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
// 
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System 
//

import Foundation

// ============================
// MARK: - Apps Plus Repository
// ============================

/// Requests the Apps Plus backend to get list of availables apps, usging also HTTP cache and local file cache
struct AppsPlusRepository: RecirculationRepositoryProtocol {

    // =======================
    // MARK: Stored properties
    // =======================

    private let feedURL: URL
    private let urlSessionConfiguration: URLSessionConfiguration
    private let cache: URLCache

    // Store in user defaults because the ETag can vary times to times
    @UserDefaultsWrapper(key: "ODSRecirculation_AppsPlus_lastResourceEtag", defaultValue: nil)
    private static var lastResourceEtag: String? // Static here to prevent to make calling methods "mutating"

    // =================
    // MARK: Initializer
    // =================

    init(feedURL: URL, urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.feedURL = feedURL
        self.urlSessionConfiguration = urlSessionConfiguration
        cache = .shared
    }

    // =======================================
    // MARK: MoreAppsRepositoryProtocol - Impl
    // =======================================

    /// Using some `URL` and  `URLSessionConfiguration` gets  `AppsPlusDTO` object from the _Apps Plus_ backend, parse it
    /// and returns a `AppsPlusListDTO`.
    /// The data got from the service is also saved in cache (local file) so as to be available if the device is offline or if some error occured.
    /// - Returns: The list of object containing all apps and sections of apps.
    /// - Throws: `Error.badConfigurationPrerequisites` if not possible to build the URL for the _Apps Plus_ backend.
    func availableAppsList() async throws -> AppsPlusListDTO {

        var request = URLRequest(url: feedURL)
        if let lastResourceEtag = Self.lastResourceEtag {
            request.addValue(lastResourceEtag, forHTTPHeaderField: "If-None-Match")
        }

        // Compute localy URL session: not possible to have struct property because try await data(for:) is mutating
        let urlSession = prepareSession()

        var appsPlusRawData: Data, response: URLResponse, httpResponse: HTTPURLResponse?
        do {
            (appsPlusRawData, response) = try await urlSession.data(for: request)
            httpResponse = response as? HTTPURLResponse
            // If current ETag is different than the last known Etag, local cache must be updated (200), otherwise should be hidden 304
            if let httpResponse = httpResponse, let etag = httpResponse.allHeaderFields["Etag"] as? String, etag != Self.lastResourceEtag {
                Self.lastResourceEtag = etag
            }
        } catch { // Timeout and connection issues managed here
            ODSLogger.error("Failed to send request to AppsPlus service: '\(error.localizedDescription)'")
            if let cachedList = cachedList(for: request) {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedList
            }
            throw RecirculationServiceErrors.sessionError
        }

        if let httpResponse = httpResponse {
            let reponseStatusCode = httpResponse.statusCode
            ODSLogger.debug("HTTP status code from AppsPlus backend: '\(reponseStatusCode)'")
            // If server error use cache (not sure it's relevant if client error like 401 Unauthorized, 403 Forbidden or 407 Proxy Authentication Required)
            if reponseStatusCode >= 500 {
                ODSLogger.error("Server error: '\(httpResponse.statusCode)'")
                if let cachedList = cachedList(for: request) {
                    ODSLogger.debug("But AppsPlus data in cache available, use them")
                    return cachedList
                }
            }
        }

        // Decode JSON payload
        var appsPlusAppsList: AppsPlusListDTO
        do {
            // Only one object sent by AppsPlus backend
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: appsPlusRawData).items[0]
        } catch {
            ODSLogger.error("Failed to decode AppsPlus service data: '\(error.localizedDescription)'")
            if let cachedList = cachedList(for: request) {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedList
            }
            throw RecirculationServiceErrors.jsonDecodingFailure
        }

        return appsPlusAppsList
    }

    // =============
    // MARK: Helpers
    // =============

    private func prepareSession() -> URLSession {
        /*
         Be cautious here because HTTP cache with ETag is used.
         So even if the backend returns a 304 status code, the `URLSession` sees it at 200 status code.
         The HTTP stack cache will be used transparently with this current configuration.
         If the cache policy for URLRequest or URLSession is changed in this implementation, the 304 status code must be managed.
         See https://jonathanblog2000.blogspot.com/2017/07/ios-uiwebview-nsurlsession-cache.html
         */
        let urlSessionConfiguration = urlSessionConfiguration
        urlSessionConfiguration.urlCache = cache
        urlSessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
        urlSessionConfiguration.timeoutIntervalForResource = 10 // 10 seconds are enough
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        urlSession.sessionDescription = "ODSRecirculation - AppsPlus Session" // Mainly for Instruments debuging
        return urlSession
    }

    /// Returns from the cache directory the content previously picked from AppsPlus backend, or nil if error occured
    /// - Returns AppsPlusListDTO?
    private func cachedList(for request: URLRequest) -> AppsPlusListDTO? {
        guard let cachedResponse = cache.cachedResponse(for: request) else {
            ODSLogger.debug("No cache is available for this request")
            return nil
        }

        var appsPlusAppsList: AppsPlusListDTO
        do {
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: cachedResponse.data).items[0]
        } catch {
            ODSLogger.error("(ノಠ益ಠ)ノ彡┻━┻ Failed to decode AppsPlus JSON data in cache: '\(error.localizedDescription)'")
            return nil
        }
        return appsPlusAppsList
    }
}
