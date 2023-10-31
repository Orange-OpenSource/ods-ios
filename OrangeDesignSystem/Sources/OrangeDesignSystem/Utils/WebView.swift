//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let source: ODSWebContentSource

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        switch source {
        case let .url(url):
            let request = URLRequest(url: url)
            webView.load(request)
        case let .html(string):
            webView.loadHTMLString(string, baseURL: nil)
        }
    }
}
