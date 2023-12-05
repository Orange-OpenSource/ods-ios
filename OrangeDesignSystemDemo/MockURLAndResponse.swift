//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import XCTest

// =====================
// MARK: - Mock Response
// =====================

/// Some mock HTTP response
struct MockResponse {
    let httpCode: Int
    let data: Data
    let headers: [String: String]

    init(httpCode: Int, data: Data, headers: [String: String] = [:]) {
        self.httpCode = httpCode
        self.data = data
        self.headers = headers
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

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override public func stopLoading() {}

    override public func startLoading() {
        guard let url = request.url else { return }

        do {
            guard let mockResponse = mockResponse(from: url)?(request) else {
                fatalError("Mock response not set")
            }

            let urlResponse = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: mockResponse.httpCode, httpVersion: "2.0", headerFields: mockResponse.headers))
            client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: mockResponse.data)
            client?.urlProtocolDidFinishLoading(self)
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

    public class func setMock(mockHandler: @escaping MockRequestHandler) {
        mockHandlers = ["Mock": mockHandler]
    }

    public class func setMocks(mockHandlers: [String: MockRequestHandler]) {
        self.mockHandlers = mockHandlers
    }
}
