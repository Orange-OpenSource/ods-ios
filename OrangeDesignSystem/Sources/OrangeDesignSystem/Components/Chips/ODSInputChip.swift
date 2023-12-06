//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSInputChip: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    private let text: Text
    private let avatarSource: ODSImage.Source?
    private let action: () -> Void
    private let removeAction: (() -> Void)?

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: Text,
                avatarSource: ODSImage.Source? = nil,
                action: @escaping () -> Void,
                removeAction: (() -> Void)? = nil)
    {
        self.text = text
        self.avatarSource = avatarSource
        self.action = action
        self.removeAction = removeAction
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: false, action: action, removeAction: removeAction) {
            text.padding(.horizontal, ODSSpacing.s)
        } leading: {
            if let avatarSource = avatarSource {
                ODSImage(source: avatarSource)
            }
        }
    }
}
