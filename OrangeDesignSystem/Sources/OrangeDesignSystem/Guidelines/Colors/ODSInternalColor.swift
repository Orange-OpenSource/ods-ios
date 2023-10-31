//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI
import UIKit

///
/// Defines all internal colors
///
enum ODSInternalColor: String {
    case cardBackground
    case primaryBackground

    /// Get the color values from resources with its name
    var color: Color {
        return Color(rawValue, bundle: Bundle.ods)
    }
}
