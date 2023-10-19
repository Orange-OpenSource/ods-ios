/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct SpacingsGuideline: Guideline {
    let title: String
    let imageName: String
    let description: String
    let pageDescription: AnyView
    
    init() {
        title = "screens.guidelines.spacings.title".🌐
        imageName = "Spacing"
        description = "screens.guidelines.spacings.description".🌐
        pageDescription = AnyView(SpacingsPageDescription())
    }
}
