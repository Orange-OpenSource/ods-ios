//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSFilterChip: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    private let text: Text
    private let avatarSource: ODSImage.Source?
    private let isSelected: Bool
    private let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: Text, avatarSource: ODSImage.Source? = nil, isSelected: Bool, action: @escaping () -> Void) {
        self.text = text
        self.avatarSource = avatarSource
        self.isSelected = isSelected
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: isSelected, action: action) {
            text
                .padding(.trailing, ODSSpacing.s)
                .padding(.leading, leadingTextPadding)
        } leading: {
            if isSelected {
                selectedLeading
            } else {
                avatar
            }
        }
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private var avatar: some View {
        if let avatarSource = avatarSource {
            ODSImage(source: avatarSource)
        }
    }

    @ViewBuilder
    private var selectedLeading: some View {
        Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .background(avatarSource == nil ? .clear : .black)
            .foregroundColor(avatarSource == nil ? .black : theme.componentColors.accent)
    }

    private var leadingTextPadding: CGFloat {
        avatarSource == nil && isSelected ? ODSSpacing.xs : ODSSpacing.s
    }
}
