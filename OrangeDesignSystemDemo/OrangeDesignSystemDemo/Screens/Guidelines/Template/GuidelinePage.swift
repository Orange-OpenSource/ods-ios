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

struct GuidelinePage: View {

    @EnvironmentObject private var themeProvider: ThemeProvider
    @AccessibilityFocusState private var requestFocus: Bool
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let guideline: Guideline

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                themeProvider.imageFromResources(name: guideline.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, ODSSpacing.m)
                    .accessibilityHidden(true)

                Text(guideline.description)
                    .accessibilityFocused($requestFocus)
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(Visibility.hidden)
            .padding(.horizontal, ODSSpacing.none)

            guideline.pageDescription
                .listRowInsets(EdgeInsets())
                .listRowSeparator(Visibility.hidden)
        }
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.horizontal, ODSSpacing.none)
        .odsNavigationTitle(guideline.name)
        .navigationbarMenuForThemeSelection()
        .background(Color(UIColor.systemBackground))
        .odsRequestAccessibleFocus(_requestFocus)
    }
}
