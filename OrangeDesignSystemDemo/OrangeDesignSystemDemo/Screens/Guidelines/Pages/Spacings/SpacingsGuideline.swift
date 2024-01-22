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

import OrangeDesignSystem
import SwiftUI

struct SpacingsGuideline: Guideline {
    let name: String
    let imageName: String
    let description: String
    let pageDescription: AnyView

    init() {
        name = °°"screens.guidelines.spacings.title"
        imageName = "Spacing"
        description = °°"screens.guidelines.spacings.description"
        pageDescription = AnyView(SpacingsPageDescription())
    }
}
