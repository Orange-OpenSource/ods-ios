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
