/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import Parma
import SwiftUI
import WebKit

// MARK: - About HTML And Markdown View

struct AboutHtmlAndMarkdownView: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    private let title: String
    private let filename: String
    private let fileExtension: String
    private let contentType: ContentType?
    
    private enum ContentType {
        case html(String)
        case htmlFile(URL)
        case markdown(String)
        
        var content: String {
            switch self {
            case .html(let content), .markdown(let content):
                return content
            case .htmlFile(let url):
                return (try? String(contentsOf: url)) ?? ""
            }
        }
    }
    
    // =================
    // MARK: Initializer
    // =================
    
    init(title: String,
         htmlFileName: String,
         fileExtension: String = "html") {

        self.title = title
        self.filename = htmlFileName
        self.fileExtension = fileExtension

        // Load content from file and convert to HTML if needed
        guard let url = Bundle.main.url(forResource: htmlFileName, withExtension: fileExtension) else {
            contentType = nil
            return
        }
        contentType = .htmlFile(url)
    }
    
    init(title: String,
         markdownFileName: String,
         fileExtension: String = "md",
         convertToHtml: Bool = false) {
        
        self.title = title
        self.filename = markdownFileName
        self.fileExtension = fileExtension
        
        // Load content from file and convert to HTML if needed
        guard let url = Bundle.main.url(forResource: markdownFileName, withExtension: fileExtension),
              let fileContent = try? String(contentsOf: url) else {
            contentType = nil
            return
        }
        
        if convertToHtml {
            if let html = try? fileContent.toHTML() {
                let withCss = Self.addHeader(to: html)
                contentType = .html(withCss)
            } else {
                contentType = nil
            }
        } else {
            contentType = .markdown(fileContent)
        }
    }
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack {
            if let contentType = contentType,
               !contentType.content.isEmpty {
                showContent(contentType: contentType)
            } else {
                Text("screens.about.file_load_failure".localized(with: [filename, fileExtension]))
                    .padding(.top, ODSSpacing.s)
                    .padding(.horizontal, ODSSpacing.l)
            }
        }
        .navigationTitle(title)
    }
    
    // ====================
    // MARK: Private Helper
    // ====================
    
    @ViewBuilder
    private func showContent(contentType: ContentType) -> some View {
        switch contentType {
        case .markdown(let markdown):
            ScrollView {
                Parma(markdown)
                    .padding(.top, ODSSpacing.s)
                    .padding(.leading, ODSSpacing.m)
            }
        case .htmlFile(let url):
            WebView(source: WebView.Source.file(url))
        case .html(let html):
            WebView(source: WebView.Source.html(html))
        }
    }
    
    public static func addHeader(to partialHTMLText: String) -> String {
        if partialHTMLText.contains("<html") {
            return partialHTMLText
        }
        var result = "<html>"
        result += "<head>"
        result += "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>"
        result += "<style>"
        result += Self.css
        result += "</style>"
        
        result += "</head>"
        if partialHTMLText.contains("<body") {
            result += partialHTMLText
        } else {
            result += "<body><p dir=\"auto\">\(partialHTMLText)</p></body>"
        }
        result += "</html>"
        return result
    }
    
    static let css =
            """
        html, body {
        margin: 8px;
        -webkit-text-size-adjust: none;
        font-family: -apple-system, sans-serif;
        }
        
        :root {
            color-scheme: light dark;
        }
        
        body {
            font: -apple-system-body;
            background-color: clear;
        }
        
        h1 {
            font: -apple-system-short-headline;
            margin-top: 1em ;
            margin-bottom: 0.3em;
        }
        
        h2 {
            font: -apple-system-short-subheadline;
            margin-top: 1em;
            margin-bottom: 0.3em;
        }
        
        p {
            font: -apple-system-body;
        }
        
        a:link, a:visited {
            color: #FF7900;
            text-decoration: none;
        }
        
        a:hover, a:active, a:focus {
            color: #527EDB;
        }
        """
}

private struct WebView: UIViewRepresentable {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    enum Source {
        case html(String)
        case file(URL)
    }
    
    let source: Source
    
    // =================
    // MARK: Initializer
    // =================

    init(source: Source) {
        self.source = source
    }
    
    // =========================
    // MARK: UIViewRepresentable
    // =========================

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch source {
        case .html(let html):
            uiView.loadHTMLString(html, baseURL: nil)
        case .file(let url):
            uiView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}
