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

import Foundation
import OrangeDesignSystem
import SwiftUI

struct ComponentsList: View {

    @Environment(\.sizeCategory) private var sizeCategory
    @EnvironmentObject private var themeProvider: ThemeProvider
    @AccessibilityFocusState private var requestFocus: AccessibilityFocusable?
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    let components: [Component]
    let columns = [GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .center)]

    // =================
    // MARK: Initializer
    // =================

    init() {
        // Remark: Components are automatically displayed sorted by their name
        let components: [Component] = [
            BannerComponent(),
            BottomSheetComponent(),
            ButtonComponent(),
            CardComponent(),
            ChipsComponent(),
            ListComponent(),
            NavigationBarComponent(),
            ProgressIndicatorComponent(),
            SliderComponent(),
            TabBarComponent(),
            TextFieldComponent(),
            ToolBarComponent(),
        ]
        self.components = components.sorted { $0.name < $1.name }
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ScrollView {
                Grid {
                    ForEach(components, id: \.id) { component in
                        NavigationLink {
                            ComponentPage(component: component)
                        } label: {
                            Card(for: component)
                                .accessibilityFocused($requestFocus, equals: .some(id: component.id))
                                // Placed here below to be sure 'components' will be evaluated in good time (compared to some assignement higher and later in body)
                                .odsRequestAccessibleFocus(_requestFocus, for: .some(id: components[0].id)) // TODO: Dirty, need to find nicer solution
                        }
                    }
                }
                .padding(.all, ODSSpacing.s)
            }
            .odsNavigationTitle("main_view.tabs.components".🌐)
            .navigationbarMenuForThemeSelection()
        }
        .navigationViewStyle(.stack)
    }

    // =====================
    // MARK: Private helper
    // =====================
    
    @ViewBuilder
    func Grid<Content>(content: () -> Content) -> some View where Content: View {
        if sizeCategory.isAccessibilityCategory {
            content()
        } else {
            LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
                content()
            }
        }
    }
        
    @ViewBuilder
    private func Card(for component: Component) -> some View {
        if sizeCategory.isAccessibilityCategory {
            ODSCardVerticalImageFirst(
                title: Text(component.name),
                imageSource: .image(themeProvider.imageFromResources(component.imageName))
            )
        } else {
            ODSCardSmall(
                title: Text(component.name),
                imageSource: .image(themeProvider.imageFromResources(component.imageName))
            )
        }
    }
}

// ===============
// MARK: - Preview
// ===============

#if DEBUG
import OrangeTheme

struct ComponentsCardsList_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            ComponentsList()
        }
    }
}
#endif
