//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ColorsGuideline: Guideline {
    let name: String
    let imageName: String
    let description: String
    let pageDescription: AnyView

    init() {
        name = °°"screens.guidelines.colors.title"
        imageName = "Colour"
        description = °°"screens.guidelines.colors.description"
        pageDescription = AnyView(ColorPageDescription())
    }
}
