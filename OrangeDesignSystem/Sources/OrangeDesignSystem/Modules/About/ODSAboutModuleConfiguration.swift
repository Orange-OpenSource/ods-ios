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

import Foundation
import SwiftUI


public struct ODSAboutApplicationInformation {

    /// Configure the application information to be displayed in the main about screen.
    ///
    /// - Parameters:
    ///    - name: The name of the application
    ///    - version: The current version of the application (something like: x.y.z)
    ///    - buildNumber: An additonal build number (will be added at the end of the version field ("x.y.z (<buildNumber>)")
    ///    - shareUrl: The Url of the application on the store
    ///    - feedbackUrl: The url feedback site
    ///
    // #swiftlint:disable multiline_parameters vertical_parameter_alignment
    public init(name: String, version: String,
                  buildNumber: String? = nil,
                  description: String,
                  shareUrl: URL,
                  feedbackUrl: URL) {
        self.name = name
        self.version = version
        self.buildNumber = buildNumber
        self.description = description
        self.shareUrl = shareUrl
        self.feedbackUrl = feedbackUrl
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    let name: String
    let version: String
    let buildNumber: String?
    let description: String
    let copyrightNotice: String = "Orange property. All rights reserved"
    let shareUrl: URL
    let feedbackUrl: URL
}
