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
import SwiftUI

public struct ODSColorDecription {

    // =======================
    // MARK: Stored Properties
    // =======================

    public let assetName: String
    public let bundle: Bundle
    public let nameForLightScheme: String?
    public let nameForDarkScheme: String?

    // =================
    // MARK: Initializer
    // =================

    public init(
        assetName: String,
        bundle: Bundle,
        nameForLightScheme: String? = nil,
        nameForDarkScheme: String? = nil)
    {
        self.assetName = assetName
        self.bundle = bundle
        self.nameForLightScheme = nameForLightScheme
        self.nameForDarkScheme = nameForDarkScheme
    }

    // =============
    // MARK: Helpers
    // =============

    public var color: Color {
        Color(assetName, bundle: bundle)
    }

    public var uiColor: UIColor {
        UIColor(named: assetName, in: bundle, compatibleWith: nil) ?? .clear
    }

    public func name(for scheme: ColorScheme) -> String? {
        scheme == .light ? nameForLightScheme : nameForDarkScheme
    }
}
