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

struct CardShadowModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(ODSInternalColor.cardBackground.color)
            .cornerRadius(10)
            .shadow(radius: ODSSpacing.xs)
            .padding(.all, ODSSpacing.s)
    }
}

#if DEBUG
struct CardShadowModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(CardShadowModifier())
    }
}
#endif
