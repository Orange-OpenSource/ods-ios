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
/// This chip offers a layout used for filtering.
///
/// - remark: The associated view __ODSFilterChipView__ is used by
/// __ODSFilterChipPicker__ to wrap chips in stacked or carousel and
/// propose a picker to apply a filter on elements easily.
///
public final class ODSFilterChip<Value> where Value: Hashable {

    // =======================
    // MARK: Stored properties
    // =======================

    let text: Text
    let leading: ODSImage.Source?
    let value: Value
    var disabled: Bool

    // =================
    // MARK: Initializer
    // =================

    /// Initialize the chip.
    ///
    /// - Parameters:
    ///     - text: Text to be displayed into the chip.
    ///     - leading: Optional leading avatar to be displayed in a circle shape at the start of the chip, preceding the content text.
    ///     - value: The value associated to the chip
    ///     - disabled: When disabled, chip will not respond to user input.
    ///
    public init(text: Text, leading: ODSImage.Source? = nil, value: Value, disabled: Bool = false) {
        self.text = text
        self.leading = leading
        self.value = value
        self.disabled = disabled
    }
}

///
/// The view representing the filter chip.
///
public struct ODSFilterChipView<Value>: View where Value: Hashable {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.theme) private var theme
    private let model: ODSFilterChip<Value>
    private let selected: Bool
    private let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the view.
    ///
    /// - Parameters:
    ///     - model: Model containing chip elements for layout.
    ///     - selected: Controls the selected state of the chip. When `true`, the chip is highlighted.
    ///     - action: The action when chip is clicked.
    ///
    public init(chip: ODSFilterChip<Value>, selected: Bool, action: @escaping () -> Void) {
        model = chip
        self.selected = selected
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: selected, action: action) {
            model.text
                .padding(.trailing, ODSSpacing.s)
                .padding(.leading, leadingTextPadding)
        } leading: {
            if selected {
                selectedLeading
            } else {
                avatar
            }
        }
        .disabled(model.disabled)
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private var avatar: some View {
        if let leading = model.leading {
            ODSImage(source: leading)
        }
    }

    @ViewBuilder
    private var selectedLeading: some View {
        Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .background(model.leading == nil ? .clear : .black)
            .foregroundColor(model.leading == nil ? .black : theme.componentColors.accent)
    }

    private var leadingTextPadding: CGFloat {
        model.leading == nil && selected ? ODSSpacing.xs : ODSSpacing.s
    }
}
