//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

struct ODSToolbarIconContent: ToolbarContent {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let items: ODSToolbarIconsItems

    // ==================
    // MARK: Initializers
    // ==================

    init(items: ODSToolbarIconsItems) {
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
            if let description4 = items.description4 {
                Spacer()
                ToolBarButton(description: description4)
            }
            if let description5 = items.description5 {
                Spacer()
                ToolBarButton(description: description5)
            }
        }
    }
}

private struct ToolBarButton: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    let description: ODSToolbarIconDesription

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Button {
            description.action()
        } label: {
            Image(systemName: description.systemName)
        }
        .frame(width: 44.0, height: 44.0)
        .tint(theme.componentColors.toolBarItem)
    }
}

#if DEBUG
struct ODSToolbarIconContent_Previews: PreviewProvider {

    static var previews: some View {
        DemoView().toolBarColors(for: ODSTheme())
    }

    struct DemoView: View {
        static let description1 = ODSToolbarIconDesription(systemName: "plus", action: {})
        static let description2 = ODSToolbarIconDesription(systemName: "square.and.arrow.up", action: {})
        static let description3 = ODSToolbarIconDesription(systemName: "square.and.pencil", action: {})
        static let description4 = ODSToolbarIconDesription(systemName: "folder", action: {})
        static let description5 = ODSToolbarIconDesription(systemName: "trash", action: {})

        @State private var labelItemsCount: Int = 2

        var iconDescriptions: ODSToolbarIconsItems {
            ODSToolbarIconsItems(
                description1: Self.description1,
                description2: Self.description2,
                description3: labelItemsCount >= 3 ? Self.description3 : nil,
                description4: labelItemsCount >= 4 ? Self.description4 : nil,
                description5: labelItemsCount >= 5 ? Self.description5 : nil)
        }

        var body: some View {
            NavigationView {
                VStack {
                    Stepper("Number of items: \(labelItemsCount)",
                            value: $labelItemsCount,
                            in: 2 ... 5)
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
