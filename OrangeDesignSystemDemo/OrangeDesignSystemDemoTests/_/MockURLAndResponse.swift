//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import Foundation
import XCTest

// swiftlint:disable line_length

// =====================
// MARK: - Mock Response
// =====================

/// Some mock HTTP response
struct MockResponse {
    let httpCode: Int
    let data: Data
    let headers: [String: String]
    let timeout: Bool

    init(httpCode: Int, data: Data, headers: [String: String] = [:], timeout: Bool = false) {
        self.httpCode = httpCode
        self.data = data
        self.headers = headers
        self.timeout = timeout
    }
}

// ========================
// MARK: - Mock URL Machine
// ========================

/// Helps to use mock URL and responses for uni tests
final class MockURLMachine: URLProtocol {

    typealias MockRequestHandler = (_ request: URLRequest) -> MockResponse

    private static var mockHandlers: [String: MockRequestHandler]?

    // MARK: - URL Protocol

    override static func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override static func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override public func stopLoading() {}

    override public func startLoading() {
        guard let url = request.url else { return }
        client?.urlProtocol(self, didFailWithError: NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil))
        do {
            guard let mockResponse = mockResponse(from: url)?(request) else {
                fatalError("🔨 Mock response not set")
            }

            if mockResponse.timeout {
                print("🔨 Timeout case")
                let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                print("🔨 HTTP code case")
                let urlResponse = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: mockResponse.httpCode, httpVersion: "2.0", headerFields: mockResponse.headers))
                client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: mockResponse.data)
                client?.urlProtocolDidFinishLoading(self)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotParseResponse))
        }
    }

    // MARK: - Service

    private func mockResponse(from url: URL) -> MockRequestHandler? {
        guard let mockHandlers = Self.mockHandlers,
              let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        // 1 request, no need to check the path
        return mockHandlers.count == 1 ? mockHandlers.first?.value : mockHandlers[urlComponents.path]
    }

    public static func setMock(mockHandler: @escaping MockRequestHandler) {
        mockHandlers = ["Mock": mockHandler]
    }

    public static func setMocks(mockHandlers: [String: MockRequestHandler]) {
        self.mockHandlers = mockHandlers
    }
}

// swiftlint:enable line_length
