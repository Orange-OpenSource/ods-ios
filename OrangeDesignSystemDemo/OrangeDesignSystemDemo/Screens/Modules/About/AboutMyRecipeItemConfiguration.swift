/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct AboutMyRecipeItemConfiguration: ODSAboutListItemConfig {
    
    var title: String
    var icon: Image
    var target: OrangeDesignSystem.ODSAboutListItemTarget
    var priority: OrangeDesignSystem.ODSAboutListItemPriority
    
    init() {
        title = "screens.modules.about.titles.my_recipes".🌐
        icon = Image("ic_folderFavourite")
        priority = 200
        target = .destination(AnyView(Text("screens.modules.about.titles.my_recipes".🌐)))
    }
}
