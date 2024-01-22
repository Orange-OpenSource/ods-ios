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

struct ODSButtonStyleLabel: View {

    // =======================
    // MARK: Stored properties
    // =======================

    let configuration: ButtonStyle.Configuration
    let foregroundColor: Color
    let backgroundColor: Color
    let borderColor: Color
    let fullWidth: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        configuration.label
            .padding(ODSSpacing.m)
            .frame(minWidth: 50, maxWidth: fullWidth ? .infinity : nil, minHeight: 50)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .buttonBorderShape(ButtonBorderShape.roundedRectangle(radius: 8.0))
            .cornerRadius(8.0)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(borderColor, lineWidth: 2.0)
            )
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}
