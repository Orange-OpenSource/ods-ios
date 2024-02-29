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
                    Text(component.description)
                        .odsFont(.bodyLRegular)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, ODSSpacing.xs)

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
        .odsNavigationTitle(component.name)
        .navigationbarMenuForThemeSelection()
    }
}

#if DEBUG
struct ComponentPage_Previews: PreviewProvider {
    struct TestComponent: Component {
        let name: String
        let imageName: String
        let description: String
        let variants: AnyView

        init() {
            name = "Test"
            imageName = "Cards"
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
