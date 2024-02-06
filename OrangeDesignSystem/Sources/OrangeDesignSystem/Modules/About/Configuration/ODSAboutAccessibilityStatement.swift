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

    let fileName: String
    let reportDetail: URL

    // =================
    // MARK: Initializer
    // =================

    /// Initializes the configuration providing the locations of the report.
    ///
    /// - Parameters:
    ///    - fileName: The name of the XML file contains the report of accessibility statement. By default must be stored in resources of the main bundle.
    ///    - reportDetail: URL to get the full detail of the accessibility statement
    public init(fileName: String, reportDetail: URL) {
        self.fileName = fileName
        self.reportDetail = reportDetail
    }
}
