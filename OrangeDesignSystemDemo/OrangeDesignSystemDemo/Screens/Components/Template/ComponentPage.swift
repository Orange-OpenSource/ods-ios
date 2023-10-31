//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ComponentPage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let component: Component
    @EnvironmentObject private var themeProvider: ThemeProvider

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            VStack {
                themeProvider.imageFromResources(component.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.m) {
                    ComponentDescription(text: component.description)

                    VariantsTitle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)
                .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)

            component.variants
        }
        .listRowSeparator(Visibility.hidden)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.horizontal, ODSSpacing.none)
        .navigationTitle(component.title)
        .navigationbarMenuForThemeSelection()
    }
}

private struct ComponentDescription: View {
    let text: String
    var body: some View {
        Text(text)
            .odsFont(.bodyRegular)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, ODSSpacing.xs)
    }
}

struct VariantsTitle: View {
    var body: some View {
        Text("misc.variants")
            .odsFont(.title1)
            .accessibilityAddTraits(.isHeader)
    }
}

struct VariantEntryItem<VariantPage>: View where VariantPage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text
    private let technicalElement: Text
    private let showThemeSelectionInNavigationBar: Bool
    private let variantPage: () -> VariantPage

    // =================
    // MARK: Initializer
    // =================

    init(
        title: String,
        technicalElement: String,
        showThemeSelectionInNavigationBar: Bool = true,
        @ViewBuilder variantPage: @escaping () -> VariantPage)
    {
        self.title = Text(title)
        self.technicalElement = Text(technicalElement)
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
            ODSListItem(title: title, subtitle: technicalElement, leading: .icon(Image(systemName: "play.circle")))
        }
        .odsListItemStyle(showSeparator: false)
    }
}

#if DEBUG
struct ComponentPage_Previews: PreviewProvider {
    struct TestComponent: Component {
        let title: String
        let imageName: String
        let description: String
        let variants: AnyView

        init() {
            title = "Test"
            imageName = "Cards_1"
            description = "This is a long text to illustrate the description area"

            variants = AnyView(Variants())
        }
    }

    struct Variants: View {
        var body: some View {
            VariantEntryItem(title: "Variant 1", technicalElement: "MyTestElement()") {
                Text("This is a Variant")
            }
        }
    }

    static var previews: some View {
        VStack {
            ComponentPage(component: TestComponent())
        }
    }
}
#endif
