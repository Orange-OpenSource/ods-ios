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

struct Toastable<Content>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Binding var showText: String?
    let content: () -> Content

    // ==========
    // MARK: Body
    // ==========
    var body: some View {
        ZStack {
            content()
            Toast(showText: $showText)
        }
    }
}

struct Toast: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Binding var showText: String?

    // ==========
    // MARK: Body
    // ==========
    var body: some View {
        if let showText = self.showText {
            Text(showText)
                .padding(.vertical, ODSSpacing.xs)
                .padding(.horizontal, ODSSpacing.s)
                .background(Color(UIColor.systemGray4)).clipShape(Capsule())
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showText = nil
                    }
                }
        }
    }
}
