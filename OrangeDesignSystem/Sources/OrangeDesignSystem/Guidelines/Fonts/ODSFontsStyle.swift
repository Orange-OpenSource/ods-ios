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

///
/// Defines all styles supported for Text elements.
/// The right font associated to the style is provider by
/// the `ODSTheme`.
///
public enum ODSFontStyle: String, CaseIterable {
    case headlineL
    case headlineS
    case titleL
    case titleM
    case titleS
    case bodyLBold
    case bodyLRegular
    case bodyM
    case bodyS
    case labelL
    case labelMBold
    case labelMRegular
    case labelS
}
