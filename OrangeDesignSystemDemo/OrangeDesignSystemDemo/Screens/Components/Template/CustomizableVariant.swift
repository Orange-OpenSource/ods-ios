//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
            .odsBottomSheetStandard(isOpen: $isOpen, title: °°"screens.components.template.customize",
                                    icon: Image(systemName: "chevron.down"), annimateIcon: true,
                                    content: self.options)
    }
}
