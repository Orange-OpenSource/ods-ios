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

///
/// Defines the version of the Application.
///
public struct ODSApplicationVersion {

    // =======================
    // MARK: Stored properties
    // =======================

    let marketingVersion: String
    let buildNumber: String?
    let buildType: String?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the version with marketing version and additional build infomration.
    /// The build type is optional (used for debug purpose)
    ///
    /// - Parameters:
    ///    - marketingVersion: The current version of the application (something like: x.y.z)
    ///    - buildNumber: The build number of a version
    ///    - buildType: (Optional) The type of build (i.e. ALPHA, BETA).
    ///
    public init(marketingVersion: String, buildNumber: String, buildType: String? = nil) {
        self.marketingVersion = marketingVersion
        self.buildNumber = buildNumber
        self.buildType = buildType
    }

    /// Initializes the version with marketing version and without build infomration.
    ///
    /// - Parameter:
    ///    - marketingVersion: The current version of the application (something like: x.y.z)
    ///
    public init(marketingVersion: String) {
        self.marketingVersion = marketingVersion
        self.buildNumber = nil
        self.buildType = nil

    }
}

///
/// Configures the system share sheet used to share the application.
///
public struct ODSAboutShareTheApplication {

    // =======================
    // MARK: Stored Properties
    // =======================

    let storeUrl: URL
    let subject: String
    let description: String

    // ==================
    // MARK: Initializers
    // ==================

    /// Initilaizes the sharing.
    ///
    /// - Parameters:
    ///    - storeUrl: The url of the application on the store.
    ///    - subject: The subject, if the application is shared with email.
    ///    - description: Can be used to describe the sharing (Content of the email, SMS, ...).
    ///
    public init(storeUrl: URL, subject: String, description: String) {
        self.storeUrl = storeUrl
        self.subject = subject
        self.description = description
    }
}

///
/// Used to configure the application description section
/// displayed in the main about screen.
///
public struct ODSAboutApplicationInformation {

    // =======================
    // MARK: Stored Properties
    // =======================

    let name: String
    let version: ODSApplicationVersion?
    let description: String?
    let copyrightNotice: String = "Orange property. All rights reserved"
    let shareConfiguration: ODSAboutShareTheApplication?
    let onFeedbackClicked: (() -> Void)?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the configuration.
    ///
    /// - Parameters:
    ///    - name: The name of the application
    ///    - version: (Optional) The current version of the application.
    ///    - shareConfiguration: (Optional) The configuration to activate the application sharing.
    ///    - onFeedbackClicked: (Optional) The action to do when feedback button is clicked
    ///
    // #swiftlint:disable multiline_parameters_brackets
    public init(
        name: String,
        version: ODSApplicationVersion? = nil,
        description: String? = nil,
        shareConfiguration: ODSAboutShareTheApplication? = nil,
        onFeedbackClicked: (() -> Void)? = nil) {
        self.name = name
        self.version = version
        self.description = description
        self.shareConfiguration = shareConfiguration
        self.onFeedbackClicked = onFeedbackClicked
    }
}
