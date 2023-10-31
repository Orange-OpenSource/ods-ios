//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
