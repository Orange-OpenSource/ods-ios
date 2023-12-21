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
public struct ODSInputChip: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    private let text: Text
    private let leading: ODSImage.Source?
    private let action: () -> Void
    private let removeAction: (() -> Void)?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the chip.
    ///
    /// - Parameters:
    ///     - text: Text to be displayed into the chip.
    ///     - leadingAvatar: Optional leading avatar to be displayed in a circle shape at the start of the chip, preceding the content text.
    ///     - action: The action when chip is clicked.
    ///     - removeAction: The action when cross is clicked.
    ///
    public init(text: Text,
                leading: ODSImage.Source? = nil,
                action: @escaping () -> Void,
                removeAction: (() -> Void)? = nil)
    {
        self.text = text
        self.leading = leading
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
            if let leading = leading {
                ODSImage(source: leading)
            }
        }
    }
}
