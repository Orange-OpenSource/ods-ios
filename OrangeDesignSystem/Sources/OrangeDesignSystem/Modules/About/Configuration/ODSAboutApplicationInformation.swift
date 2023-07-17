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
/// Define the version of the Application.
/// Today used for About Module only
///
public struct ODSApplicationVersion {

    // ========================
    // MARK: Stored properties
    // ========================

    let marketingVersion: String
    let buildNumber: String?
    let buildType: String?

    // ===================
    // MARK: Initializers
    // ===================

    /// Initialize the version with marketing version and optional additional build infomration.
    /// The build type is used for debug purpose.
    ///
    /// - Parameters:
    ///    - marketingVersion: The current version of the application (something like: x.y.z)
    ///    - buildNumber: The build number of a version
    ///    - buildType: (Optional) The type of build (i.e. DEBUG, QUALIF).
    ///
    public init(marketingVersion: String, buildNumber: String, buildType: String? = nil) {
        self.marketingVersion = marketingVersion
        self.buildNumber = buildNumber
        self.buildType = buildType
    }
    public init(marketingVersion: String) {
        self.marketingVersion = marketingVersion
        self.buildNumber = nil
        self.buildType = nil

    }
}

/// Configure the system share sheet
/// used to share the application.
///
public struct ODSAboutShareTheApplication {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let url: URL
    let subject: String
    let description: String

    // ==================
    // MARK: Initializers
    // ==================
    
    /// Initilaize the sharing.
    ///
    /// - Parameters:
    ///     - url: The url of the application on the store.
    ///     - subject: The subject, if the application is shared with email.
    ///     - description: Can be used to describe the sharing (Content of the email, SMS, ...).
    ///
    public init(url: URL, subject: String, description: String) {
        self.url = url
        self.subject = subject
        self.description = description
    }
}



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

    /// Configure the application information to be displayed in the main about screen.
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
