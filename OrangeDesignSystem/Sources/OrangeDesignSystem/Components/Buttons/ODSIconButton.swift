//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

///
/// Simple button with icon.
///
public struct ODSIconButton: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let image: Image
    let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the button.
    ///
    /// - Parameters:
    ///   - image: The icon to be displayed.
    ///   - action: Will be called when the user clicks the button.
    ///
    public init(image: Image, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Button {
            action()
        } label: {
            ODSIcon(image)
        }
    }
}
