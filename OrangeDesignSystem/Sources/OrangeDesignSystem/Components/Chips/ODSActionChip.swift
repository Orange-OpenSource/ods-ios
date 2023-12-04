//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSActionChip: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let text: Text
    private let leadingIcon: Image
    private let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: Text, leadingIcon: Image, action: @escaping () -> Void) {
        self.text = text
        self.leadingIcon = leadingIcon
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: false, action: action) {
            text.padding(.horizontal, ODSSpacing.s)
        } leading: {
            ODSImage(source: .image(leadingIcon))
        }
    }
}
