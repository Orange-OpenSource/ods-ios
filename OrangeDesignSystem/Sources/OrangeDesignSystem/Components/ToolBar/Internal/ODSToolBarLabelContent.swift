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

import SwiftUI

struct ODSToolbarLabelContent: ToolbarContent {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let items: ODSToolbarLabeledItems

    // ==================
    // MARK: Initializers
    // ==================

    init(items: ODSToolbarLabeledItems) {
        self.items = items
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            ToolBarButton(description: items.description1)

            Spacer()
            ToolBarButton(description: items.description2)

            if let description3 = items.description3 {
                Spacer()
                ToolBarButton(description: description3)
            }
        }
    }
}

private struct ToolBarButton: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    let description: ODSToolbarLabelDesription

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Button(description.text, action: { description.action() })
            .tint(theme.componentColors.toolBarItem)
    }
}

#if DEBUG
struct ODSToolbarLabelContent_Previews: PreviewProvider {

    static var previews: some View {
        DemoView()
            .toolBarColors(for: ODSTheme())
    }

    struct DemoView: View {
        static let description1 = ODSToolbarLabelDesription(text: "Action 1", action: {})
        static let description2 = ODSToolbarLabelDesription(text: "Action 2", action: {})
        static let description3 = ODSToolbarLabelDesription(text: "Action 3", action: {})

        @State private var labelItemsCount: Int = 2

        var iconDescriptions: ODSToolbarLabeledItems {
            ODSToolbarLabeledItems(
                description1: Self.description1,
                description2: Self.description2,
                description3: labelItemsCount >= 3 ? Self.description3 : nil)
        }

        var body: some View {
            NavigationView {
                VStack {
                    Stepper("Number of items: \(labelItemsCount)",
                            value: $labelItemsCount,
                            in: 2 ... 3)
                    Spacer()
                }
                .padding(.horizontal, ODSSpacing.m)
                .odsToolBar(items: self.iconDescriptions)
            }
            .toolBarColors(for: ODSTheme())
        }
    }
}
#endif
