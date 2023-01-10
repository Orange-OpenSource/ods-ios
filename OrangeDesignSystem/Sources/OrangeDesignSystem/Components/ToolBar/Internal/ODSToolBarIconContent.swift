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

import SwiftUI

struct ODSToolbarIconContent: ToolbarContent {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
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
            button(for: items.description1)

            Spacer()
            button(for: items.description2)

            if let description3 = items.description3 {
                Spacer()
                button(for: description3)
            }
            if let description4 = items.description4 {
                Spacer()
                button(for: description4)
            }
            if let description5 = items.description5 {
                Spacer()
                button(for: description5)
            }
        }
    }

    // =============
    // MARK: Helpers
    // =============

    private func button(for description: ODSToolbarIconDesription) -> some View {
        Button {
            description.action()
        } label: {
            Image(systemName: description.systemName)
        }
        .tint(theme.componentColors.toolBarItem)
    }
}

#if DEBUG
struct ODSToolbarIconContent_Previews: PreviewProvider {
   
    static var previews: some View {
           DemoView()
               .toolBarColors(for: ODSTheme())
    }
        
    struct DemoView: View {
        static let description1 = ODSToolbarIconDesription(systemName: "plus", action: {})
        static let description2 = ODSToolbarIconDesription(systemName: "square.and.arrow.up", action: {})
        static let description3 = ODSToolbarIconDesription(systemName: "square.and.pencil", action: {})
        static let description4 = ODSToolbarIconDesription(systemName: "folder", action: {})
        static let description5 = ODSToolbarIconDesription(systemName: "trash", action: {})

        @State private var labelItemsCount: Int = 2

        var iconItems: ODSToolbarIconsItems {
            ODSToolbarIconsItems(
                description1: Self.description1,
                description2: Self.description2,
                description3: labelItemsCount >= 3 ? Self.description3 : nil,
                description4: labelItemsCount >= 4 ? Self.description4 : nil,
                description5: labelItemsCount >= 5 ? Self.description5 : nil
            )
        }

        var body: some View {
            NavigationView {
                VStack {
                    Stepper("Number of items: \(labelItemsCount)",
                            value: $labelItemsCount,
                            in: 2 ... 5)
                    Spacer()
                }
                .padding(.horizontal , ODSSpacing.m)
                .odsToolBar(items: self.iconItems)
            }
            .toolBarColors(for: ODSTheme())
        }
    }
}
#endif
