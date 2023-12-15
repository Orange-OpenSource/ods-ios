//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// <a href="https://system.design.orange.com/0c1af118d/p/85a52b-components/b/1497a4" target="_blank">ODS Chips</a>.
///
/// Chips are small components containing a number of elements that represent a calendar event or contact.
///
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

    /// Create the chip.
    ///
    /// - Parameters:
    ///     - text: Text to be displayed into the chip.
    ///     - leadingIcon: Optional leading icon to be displayed at the start of the chip, preceding the content text.
    ///     - action: Callback action invoked when chip is clicked.
    ///
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
            ODSImage(source: .image(leadingIcon.renderingMode(.template)))
                .padding(.leading, ODSSpacing.xs)
        }
    }
}
