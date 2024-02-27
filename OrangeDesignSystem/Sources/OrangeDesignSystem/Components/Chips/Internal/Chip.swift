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

// ============
// MARK: - Chip
// ============

struct Chip<Leading, Text>: View where Leading: View, Text: View {

    @ScaledMetric(relativeTo: .body) private var leadingHeight = 24
    @ScaledMetric(relativeTo: .body) private var frameHeight = 32
    @ScaledMetric(relativeTo: .body) private var labelPadding = ODSSpacing.xs

    // =======================
    // MARK: Stored properties
    // =======================

    private let isSelected: Bool
    private let action: () -> Void
    private let removeAction: (() -> Void)?
    @ViewBuilder private let text: () -> Text
    @ViewBuilder private let leading: () -> Leading

    // =================
    // MARK: Intializers
    // =================

    init(isSelected: Bool,
         action: @escaping () -> Void,
         removeAction: (() -> Void)? = nil,
         @ViewBuilder text: @escaping () -> Text,
         @ViewBuilder leading: @escaping () -> Leading)
    {
        self.isSelected = isSelected
        self.action = action
        self.removeAction = removeAction
        self.text = text
        self.leading = leading
    }

    init(isSelected: Bool,
         action: @escaping () -> Void,
         removeAction: (() -> Void)? = nil,
         @ViewBuilder text: @escaping () -> Text) where Leading == EmptyView
    {
        self.isSelected = isSelected
        self.action = action
        self.removeAction = removeAction
        self.text = text
        leading = { EmptyView() }
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: ODSSpacing.none) {

                leading()
                    .frame(width: leadingHeight, height: leadingHeight)
                    .clipShape(Circle())

                text()
                    .odsFont(.bodyS)
                    .multilineTextAlignment(.center)
                    .frame(minHeight: leadingHeight)

                removeButton
                    .frame(width: leadingHeight, height: leadingHeight)
            }
            .padding(.all, labelPadding)
            .frame(height: frameHeight)
            .modifier(ChipContentModifier(isSelected: isSelected))

        }
    }

    @ViewBuilder
    var removeButton: some View {
        if let removeAction = removeAction {
            Button(action: removeAction) {
                Image("ic_close", bundle: Bundle.ods)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primary)
            }
        }
    }
}

// =============================
// MARK: - Chip Content Modifier
// =============================

private struct ChipContentModifier: ViewModifier {

    let isSelected: Bool
    private let lineWidth: CGFloat = 1.0
    @Environment(\.theme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        if isSelected {
            content
                .foregroundColor(.black)
                .background(theme.componentColors.accent, in: Capsule())
                .opacity(isEnabled ? 1 : 0.5)
                .accessibilityAddTraits(.isSelected)
        } else {
            content
                .foregroundColor(.primary)
                .overlay(Capsule().stroke(Color.primary, lineWidth: lineWidth))
                .padding(.all, lineWidth)
                .opacity(isEnabled ? 1 : 0.5)
                .accessibilityRemoveTraits(.isSelected)
        }
    }
}
