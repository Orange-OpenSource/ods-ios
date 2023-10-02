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

public struct ODSButtonStyle: ButtonStyle {

    // =======================
    // MARK: Stored properties
    // =======================
    
    let emphasis: ODSButton.Emphasis

    // =================
    // MARK: Initializer
    // =================

    public init(emphasis: ODSButton.Emphasis) {
        self.emphasis = emphasis
    }
    
    // ==========
    // MARK: Body
    // ==========

    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(16)
            .modifier(ODSButtonStyleModifier(emphasis: emphasis))
    }
}

extension View {
    func odsButtonEmphasis(_ emphasis: ODSButton.Emphasis) -> some View {
        self.buttonStyle(ODSButtonStyle(emphasis: emphasis))
    }
}


// MARK: style modifier

/// Modifier to apply the right style on the button according to the emphais
struct ODSButtonStyleModifier: ViewModifier {
    let emphasis: ODSButton.Emphasis
    @Environment(\.theme) var theme

    @ViewBuilder
    func body(content: Content) -> some View {
        switch emphasis {
        case .high:
            let style = ODSShapedButtonStyle(shapeType: .filled,
                                             foregroundColor: theme.componentColors.highEmphasisText,
                                             backgroundColor: theme.componentColors.accent)
            content.buttonStyle(style)
        case .medium:
            let style = ODSShapedButtonStyle(shapeType: .filled,
                                             foregroundColor: Color(UIColor.systemBackground),
                                             backgroundColor: Color(UIColor.label))
            content.buttonStyle(style)
        case .low:
            let style = ODSShapedButtonStyle(shapeType: .bordered,
                                             foregroundColor: Color(UIColor.label),
                                             backgroundColor: Color.clear)
            content.buttonStyle(style)
        case .lowest:
            content
        }
    }
}

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

// MARK: Shaped and bordered style
private struct ODSBorderedButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let foregroundColor: Color
    let backgroundColor: Color

    var body: some View {
        if isEnabled {
            configuration.label
                .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(foregroundColor, lineWidth: 2.0))
        } else {
            ODSDisabledButtonLabel(configuration: configuration)
        }
    }
}

// MARK: Style for disable state
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
