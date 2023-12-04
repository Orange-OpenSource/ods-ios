//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSChoiceChip: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let text: Text
    private let isSelected: Bool
    private let action: () -> Void

    // =================
    // MARK: Intializers
    // =================

    public init(text: Text, isSelected: Bool, action: @escaping () -> Void) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Chip(isSelected: isSelected, action: action) {
            text.padding(.horizontal, ODSSpacing.s)
        }
    }
}
