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
