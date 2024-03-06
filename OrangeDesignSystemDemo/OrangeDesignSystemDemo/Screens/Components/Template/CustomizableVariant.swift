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

struct CustomizableVariant<Variant, Options>: View where Variant: View, Options: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State var isOpen = false
    let variant: () -> Variant
    let options: () -> Options

    // =================
    // MARK: Initializer
    // =================

    init(@ViewBuilder variant: @escaping () -> Variant,
         @ViewBuilder options: @escaping () -> Options)
    {
        self.variant = variant
        self.options = options
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        variant()
            .task {
                withAnimation(Animation.linear.delay(0.5)) {
                    self.isOpen = true
                }
            }
            .odsBottomSheetStandard(isOpen: $isOpen, 
                                    title: °°"screens.components.template.customize",
                                    accessibilityStateLabels: (opened: °°"screens.components.template.customize.label.opened",
                                                               closed: °°"screens.components.template.customize.label.closed"),
                                    accessibilityStateHints: (opened: °°"screens.components.template.customize.hint.opened",
                                                              closed: °°"screens.components.template.customize.hint.closed"),
                                    icon: Image(systemName: "chevron.down"), 
                                    animateIcon: true,
                                    content: self.options)
    }
}
