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

import OrangeDesignSystem
import SwiftUI

struct SecureTextFieldVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @State private var textToEdit: String = ""

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            SecureField("screens.components.textfields.variants.secure.hint", text: $textToEdit)
                .odsTextFieldStyle()
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)

            Spacer()
        }
    }
}
