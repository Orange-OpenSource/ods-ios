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

/// Used to configure the accessibility statement page.
///
/// The module adds an entry into the list of items that allows user to display this page.
public struct ODSAboutAccessibilityStatement {

    // =======================
    // MARK: Stored Properties
    // =======================

    let conformityStatus: String
    let fileName: String
    let reportDetail: URL

    // =================
    // MARK: Initializer
    // =================

    /// Initializes the configuration for the accessibility statement.
    ///
    /// - Parameters:
    ///    - conformityStatus: The conformity status associated to the accessibility audit, used in the menu entry, should be a localized string
    ///    - fileName: The name of the XML file contains the report of accessibility statement. By default must be stored in resources of the main bundle.
    ///    - reportDetail: URL to get the full details of the accessibility statement
    public init(conformityStatus: String, fileName: String, reportDetail: URL) {
        self.conformityStatus = conformityStatus
        self.fileName = fileName
        self.reportDetail = reportDetail
    }
}
