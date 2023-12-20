//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

struct Chip<Leading, Text>: View where Leading: View, Text: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let isSelected: Bool
    private let action: () -> Void
    private let removeAction: (() -> Void)?
    @ViewBuilder private let text: () -> Text
    @ViewBuilder private let leading: () -> Leading

    @ScaledMetric(relativeTo: .body) private var leadingHeight = 24
    @ScaledMetric(relativeTo: .body) private var frameHeight = 32
    @ScaledMetric(relativeTo: .body) private var labelPadding = ODSSpacing.xs

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
                    .odsFont(.bodyRegular)
                    .multilineTextAlignment(.center)

                removeButton
                    .frame(width: leadingHeight, height: leadingHeight)
            }
            .padding(.all, labelPadding)
            .modifier(ChipContentModifier(isSelected: isSelected))
            .frame(height: frameHeight)
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

struct ChipContentModifier: ViewModifier {

    let isSelected: Bool
    @Environment(\.theme) var theme
    @Environment(\.isEnabled) var isEnabled

    func body(content: Content) -> some View {
        if isSelected {
            content
                .foregroundColor(.black)
                .background(theme.componentColors.accent, in: Capsule())
                .opacity(isEnabled ? 1 : 0.5)
        } else {
            content
                .foregroundColor(.primary)
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                .padding(.all, 1)
                .opacity(isEnabled ? 1 : 0.5)
        }
    }
}
