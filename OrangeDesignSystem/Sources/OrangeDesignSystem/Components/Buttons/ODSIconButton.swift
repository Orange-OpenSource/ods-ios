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
