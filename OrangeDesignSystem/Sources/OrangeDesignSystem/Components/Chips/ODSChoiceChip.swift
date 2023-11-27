//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSChoiceChip: View {

    private let text: Text
    private let isSelected: Bool
    private let action: () -> Void

    public init(text: Text, isSelected: Bool, action: @escaping () -> Void) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            text
                .odsFont(.bodyRegular)
                .padding(.vertical, ODSSpacing.xs)
                .padding(.horizontal, ODSSpacing.m)
        }
        .buttonStyle(ODSChoiceChipStyle(isSelected: isSelected))
    }
}

private struct ODSChoiceChipStyle: ButtonStyle {

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
                    .background(theme.componentColors.accent, in: Capsule())
                    .opacity(isEnabled ? 1 : 0.5)
            } else {
                configuration
                    .label
                    .foregroundColor(.primary)
                    .overlay(Capsule().stroke(Color(UIColor.label), lineWidth: 1))
                    .padding(.vertical, 1)
                    .opacity(isEnabled ? 1 : 0.5)
            }
        }
    }
}
