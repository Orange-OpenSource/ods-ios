//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
                .odsFont(.subhead)
                .foregroundColor(Color(UIColor.systemGray3))

        case let .iButton(action, text):
            HStack {
                text
                    .odsFont(.subhead)
                    .foregroundColor(Color(UIColor.systemGray3))

                ODSIconButton(image: Image(systemName: "info.circle"), action: action)
                    .foregroundColor(theme.componentColors.accent)
                    .buttonStyle(PlainButtonStyle())
            }

        case let .toggle(isOn):
            Toggle(isOn: isOn) {
                EmptyView()
            }

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
