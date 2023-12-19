//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct GuidelinePage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let guideline: Guideline
    @EnvironmentObject private var themeProvider: ThemeProvider

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                themeProvider.imageFromResources(guideline.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, ODSSpacing.m)
                    .accessibilityHidden(true)

                Text(guideline.description)
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
        .navigationTitle(guideline.name)
        .navigationbarMenuForThemeSelection()
        .background(Color(UIColor.systemBackground))
    }
}
