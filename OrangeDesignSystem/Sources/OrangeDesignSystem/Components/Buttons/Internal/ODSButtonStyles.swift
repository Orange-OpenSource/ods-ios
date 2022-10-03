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

// MARK: Shaped and filled style
struct ODSShapedButtonStyle: ButtonStyle {
    enum ShapeType {
        case filled
        case bordered
    }

    let shapeType: ShapeType
    let foregroundColor: Color
    let backgroundColor: Color

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> some View {
        switch shapeType {
        case .filled:
            ODSFilledButtonLabel(configuration: configuration,
                                 foregroundColor: foregroundColor,
                                 backgroundColor: backgroundColor)
                .opacity(configuration.isPressed ? 0.3 : 1.0)
        case .bordered:
            ODSBorderedButtonLabel(configuration: configuration,
                                   foregroundColor: foregroundColor,
                                   backgroundColor: backgroundColor)
                .opacity(configuration.isPressed ? 0.3 : 1.0)
        }
    }
}

private struct ODSFilledButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let foregroundColor: Color
    let backgroundColor: Color

    var body: some View {
        if isEnabled {
            configuration.label
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .cornerRadius(8.0)
        } else {
            ODSDisabledButtonLabel(configuration: configuration)
        }
    }
}

private struct ODSBorderedButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let foregroundColor: Color
    let backgroundColor: Color

    var body: some View {
        if isEnabled {
            configuration.label
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(foregroundColor, lineWidth: 1.0))
        } else {
            ODSDisabledButtonLabel(configuration: configuration)
        }
    }
}

private struct ODSDisabledButtonLabel: View {
    let configuration: ButtonStyle.Configuration

    let foregroundColor = Color(UIColor.tertiaryLabel)
    let backgroundColor = Color(UIColor.quaternarySystemFill)

    var body: some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(8.0)
    }
}
