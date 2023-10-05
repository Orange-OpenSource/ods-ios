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
