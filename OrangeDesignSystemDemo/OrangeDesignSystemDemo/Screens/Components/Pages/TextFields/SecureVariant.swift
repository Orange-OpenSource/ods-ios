/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
            SecureField("screens.guidelines.textfields.variants.secure.hint", text: $textToEdit)
                .odsTextFieldStyle()
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
            
            Spacer()
        }
    }
}
