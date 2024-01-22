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
/// ODSChoiceChip represents a single choice from a set. Choice chips contain text describing an associated value.
///
/// - remark: The associated view __ODSChoiceChipView__ is used by
/// __ODsChocieChipPicker__ to wrap chips in stacked or carousel and
/// propose a picker to catch the choice from a set of options.
///
public final class ODSChoiceChip<Value> where Value: Hashable {

    // =======================
    // MARK: Stored properties
    // =======================

    let text: Text
    let value: Value

    // =================
    // MARK: Intializers
    // =================

    /// Initialize the chip.
    ///
    /// - Parameters:
    ///     - text: Text to be displayed into the chip.
    ///     - value: The value associated to the chip
    ///
    public init(text: Text, value: Value) {
        self.text = text
        self.value = value
    }
}

///
/// The view representing the choice chip.
///
public struct ODSChoiceChipView<Value>: View where Value: Hashable {

    // =======================
    // MARK: Stored properties
    // =======================

    private let chip: ODSChoiceChip<Value>
    private let selected: Bool
    private let action: () -> Void

    // =================
    // MARK: Intializers
    // =================

    public init(chip: ODSChoiceChip<Value>, selected: Bool, action: @escaping () -> Void) {
        self.chip = chip
        self.selected = selected
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: selected, action: action) {
            chip.text.padding(.horizontal, ODSSpacing.s)
        }
    }
}
