//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSActionChip: View {

    private let text: Text
    private let leadingIcon: Image
    private let action: () -> Void

    public init(text: Text, leadingIcon: Image, action: @escaping () -> Void) {
        self.text = text
        self.leadingIcon = leadingIcon
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                ODSIcon(leadingIcon, width: 24, height: 24)
//                leadingIcon
//                    .renderingMode(.template)
//                    .resizable()
//                    .frame(width: 24, height: 24, alignment: .center)
                text.odsFont(.bodyRegular)
            }
            .padding(.vertical, ODSSpacing.xs)
            .padding(.horizontal, ODSSpacing.s)
        }
        .buttonStyle(ODSActionChipStyle())
    }
}

struct ODSActionChipStyle: ButtonStyle {

    @Environment(\.isEnabled) var isEnabled
    @Environment(\.theme) var theme

    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            configuration
                .label
                .foregroundColor(.primary)
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                .padding(.vertical, 1)
                .opacity(0.5)
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
