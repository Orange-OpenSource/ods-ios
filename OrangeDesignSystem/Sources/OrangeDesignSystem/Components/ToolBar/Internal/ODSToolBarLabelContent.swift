//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
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
                description3: labelItemsCount >= 3 ? Self.description3 : nil
            )
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
