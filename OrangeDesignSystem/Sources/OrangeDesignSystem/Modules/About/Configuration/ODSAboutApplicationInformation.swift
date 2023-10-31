//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import SwiftUI

/// Defines the version of the application.
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

    public init(marketingVersion: String, buildNumber: String, buildType: String? = nil) {
        self.marketingVersion = marketingVersion
        self.buildNumber = buildNumber
        self.buildType = buildType
    }

    /// Initializes the version with marketing version and without build infomration.
    ///
    /// - Parameter:
    ///    - marketingVersion: The current version of the application (something like: x.y.z)
    public init(marketingVersion: String) {
        self.marketingVersion = marketingVersion
        buildNumber = nil
        buildType = nil
    }
}

/// Configures the system share sheet used to share the application.
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

    /// Initializes the sharing.
    ///
    /// - Parameters:
    ///    - storeUrl: The url of the application on the store.
    ///    - subject: The subject, if the application is shared with email.
    ///    - description: Can be used to describe the sharing (Content of the email, SMS, ...).
    ///
    ///  Remark: Do not copy the URL in the description because it can be presented twice (e.g. in copy action)
    public init(storeUrl: URL, subject: String, description: String) {
        self.storeUrl = storeUrl
        self.subject = subject
        self.description = description
    }
}

/// Used to configure the application description section displayed in the main about screen.
public struct ODSAboutApplicationInformation {

    // =======================
    // MARK: Stored Properties
    // =======================

    let name: String
    let version: ODSApplicationVersion?
    let description: String?
    let copyrightNotice: String = "modules.about.copyright".🌐
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
    public init(
        name: String,
        version: ODSApplicationVersion? = nil,
        description: String? = nil,
        shareConfiguration: ODSAboutShareTheApplication? = nil,
        onFeedbackClicked: (() -> Void)? = nil)
    {
        self.name = name
        self.version = version
        self.description = description
        self.shareConfiguration = shareConfiguration
        self.onFeedbackClicked = onFeedbackClicked
    }
}
