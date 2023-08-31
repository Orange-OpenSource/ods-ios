//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import SwiftUI
import OrangeDesignSystem

struct CustomizableVariant<Variant, Options>: View  where Variant: View, Options: View {

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
         @ViewBuilder options: @escaping () -> Options) {
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
            .odsBottomSheetStandard(isOpen: $isOpen, title: "Customize",
                                    icon: Image(systemName: "chevron.down"), annimateIcon: true,
                                    content: self.options)
    }
}
