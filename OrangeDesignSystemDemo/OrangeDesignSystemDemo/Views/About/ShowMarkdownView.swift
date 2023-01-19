//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import OrangeDesignSystem
import Parma
import SwiftUI
import WebKit

struct ShowMarkdownView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: String
    private let filename: String
    private let fileExtension: String
    private let contentType: ContentType?

    enum ContentType {
        case html(String)
        case markdown(String)
        
        var content: String {
            switch self {
            case .html(let content), .markdown(let content):
                return content
            }
        }
    }

    // =================
    // MARK: Initializer
    // =================

    init(title: String,
         fileName: String,
         fileExtension: String = "md",
         convertToHtml: Bool = false) {
        self.title = title
        self.filename = fileName
        self.fileExtension = fileExtension
        
        // Load content from file and convert to html if needed
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let fileContent = try? String(contentsOf: url) else {
            contentType = nil
            return
        }
        
        if convertToHtml {
            if let html = try? fileContent.toHTML() {
                contentType = .html(html)
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
                Text("Unable to load \(filename).\(fileExtension)")
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
    func showContent(contentType: ContentType) -> some View {
        switch contentType {
        case .markdown(let markdown):
            ScrollView {
                Parma(markdown)
                    .padding(.top, ODSSpacing.s)
                    .padding(.horizontal, ODSSpacing.m)
            }
        case .html(let html):
            WebView(html: html)
                .padding(.top, ODSSpacing.s)
                .padding(.leading, ODSSpacing.m)
        }
    }
}

private struct WebView: UIViewRepresentable {

    let html: String

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
