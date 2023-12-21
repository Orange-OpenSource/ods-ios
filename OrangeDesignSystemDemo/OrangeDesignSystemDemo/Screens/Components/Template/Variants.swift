//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct VariantsTitle: View {
    var body: some View {
        Text("misc.variants")
            .odsFont(.titleL)
            .accessibilityAddTraits(.isHeader)
    }
}

struct VariantEntryItem<VariantPage>: View where VariantPage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: LocalizedStringKey
    private let technicalElement: String
    private let showThemeSelectionInNavigationBar: Bool
    private let variantPage: () -> VariantPage

    // =================
    // MARK: Initializer
    // =================

    init(
        title: LocalizedStringKey,
        technicalElement: String,
        showThemeSelectionInNavigationBar: Bool = true,
        @ViewBuilder variantPage: @escaping () -> VariantPage)
    {
        self.title = title
        self.technicalElement = technicalElement
        self.showThemeSelectionInNavigationBar = showThemeSelectionInNavigationBar
        self.variantPage = variantPage
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationLink {
            if showThemeSelectionInNavigationBar {
                variantPage().navigationbarMenuForThemeSelection()
            } else {
                variantPage()
            }
        } label: {
            ODSListItem(title: Text(title), subtitle: Text(verbatim: technicalElement), leading: .icon(Image(systemName: "play.circle")))
        }
        .odsListItemStyle(showSeparator: false)
    }
}
