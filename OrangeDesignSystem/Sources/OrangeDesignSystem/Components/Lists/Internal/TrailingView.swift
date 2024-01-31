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

struct TrailingView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
    let element: ODSListItem.TrailingElement
    let height: CGFloat

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch element {
        case let .textOnly(text):
            text
                .odsFont(.bodyS)
                .foregroundColor(Color(UIColor.systemGray3))

        case let .iButton(action, text):
            HStack {
                text
                    .odsFont(.bodyS)
                    .foregroundColor(Color(UIColor.systemGray3))

                ODSIconButton(image: Image(systemName: "info.circle"), action: action)
                    .foregroundColor(theme.componentColors.accent)
                    .buttonStyle(PlainButtonStyle())
            }

        case .toggle:
            // Do nothing here, because toggle is always managed in ODSListItem.
            EmptyView()

        case let .checkmark(isVisible):
            if isVisible {
                Image(systemName: "checkmark")
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    .foregroundColor(theme.componentColors.accent)
                    .frame(height: height)
            } else {
                EmptyView()
            }
        }
    }
}
