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
