//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

struct Chip<Leading, Text>: View where Leading: View, Text: View {

    let isSelected: Bool
    let action: () -> Void
    @ViewBuilder let text: () -> Text
    @ViewBuilder let leading: () -> Leading

    init(isSelected: Bool, action: @escaping () -> Void,
         @ViewBuilder text: @escaping () -> Text,
         @ViewBuilder leading: @escaping () -> Leading)
    {
        self.text = text
        self.isSelected = isSelected
        self.action = action
        self.leading = leading
    }

    init(isSelected: Bool, action: @escaping () -> Void,
         @ViewBuilder text: @escaping () -> Text) where Leading == EmptyView
    {
        self.text = text
        self.isSelected = isSelected
        self.action = action
        leading = { EmptyView() }
    }

    var body: some View {
        Button {
            action()
        } label: {
            Label { text() } icon: { leading() }
                .labelStyle(ChipLabelStyle())
        }
        .buttonStyle(ChipButtoonStyle(isSelected: isSelected))
    }
}

struct ChipLabelStyle: LabelStyle {

    @ScaledMetric(relativeTo: .body) var leadingHeight = 24
    @ScaledMetric(relativeTo: .body) var frameHeight = 32
    @ScaledMetric(relativeTo: .body) var labelPadding = ODSSpacing.xs

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: ODSSpacing.none) {
            configuration.icon
                .frame(width: leadingHeight, height: leadingHeight)
                .clipShape(Circle())

            configuration.title
                .odsFont(.bodyRegular)
                .multilineTextAlignment(.center)
        }
        .padding(.all, labelPadding)
        .frame(height: frameHeight)
    }
}

struct ChipButtoonStyle: ButtonStyle {

    @Environment(\.isEnabled) var isEnabled
    @Environment(\.theme) var theme
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            configuration
                .label
                .foregroundColor(.primary)
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                .padding(.vertical, 1)
                .opacity(0.5)
        } else {
            if isSelected {
                configuration.label
                    .foregroundColor(.black)
                    .padding(.vertical, 1)
                    .background(theme.componentColors.accent, in: Capsule())
                    .opacity(isEnabled ? 1 : 0.5)
            } else {
                configuration
                    .label
                    .foregroundColor(.primary)
                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                    .padding(.vertical, 1)
                    .opacity(isEnabled ? 1 : 0.5)
            }
        }
    }
}
