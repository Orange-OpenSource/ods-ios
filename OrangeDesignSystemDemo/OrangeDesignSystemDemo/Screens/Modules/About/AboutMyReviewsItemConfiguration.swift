//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct AboutMyReviewsItemConfiguration: ODSAboutListItemConfig {

    var title: String
    var icon: Image
    var target: OrangeDesignSystem.ODSAboutListItemTarget
    var priority: OrangeDesignSystem.ODSAboutListItemPriority

    init() {
        title = °°"screens.modules.about.titles.my_review"
        icon = Image("ic_subtitles")
        priority = 201
        target = .destination(AnyView(Text("screens.modules.about.titles.my_review")))
    }
}
