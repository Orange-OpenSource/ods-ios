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

// =================
// MARK: PUBLIC API
// =================

// MARK: Button configuration

public struct ODSImageDescription {
    let image: Image
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let foregroundColor: Color

    public init(image: Image, imageWidth: CGFloat, imageHeight: CGFloat, foregroundColor: Color = .primary) {
        self.image = image
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.foregroundColor = foregroundColor
    }
}

// MARK: Button label configuration

public struct ODSGenericButtonContent: View {
    let topText: String?
    let bottomText: String?
    let textColor: Color
    let imageDescription: ODSImageDescription?

    public init(imageDescription: ODSImageDescription? = nil, topText: String? = nil, bottomText: String? = nil, textColor: Color = .primary) {
        self.imageDescription = imageDescription
        self.topText = topText
        self.bottomText = bottomText
        self.textColor = textColor
    }

    public var body: some View {
        HStack(alignment: .center) {
            if let imageDescription = imageDescription {
                imageDescription.image
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(imageDescription.foregroundColor)
                    .frame(width: imageDescription.imageWidth, height: imageDescription.imageHeight)
            }

            VStack(alignment: imageDescription == nil ? .center : .leading) {
                if let topText = topText {
                    Text(topText)
                        .odsFont(style: .bodyBold)
                        .foregroundColor(textColor)
                }

                if let bottomText = bottomText {
                    Text(bottomText)
                        .odsFont(style: .caption1Regular)
                        .foregroundColor(textColor)
                }
            }
        }
    }
}

// MARK: Filled Button style

public struct ODSFilledButtonStyle: ButtonStyle {
    let backgroundColor: Color?

    public init(backgroundColor: Color? = ODSColor.coreOrange.color) {
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        return ODSFilledButtonLabel(configuration: configuration, backgroundColor: backgroundColor)
    }
}

// MARK: Bordered Button style

public struct ODSBorderedButtonStyle: ButtonStyle {
    let backgroundColor: Color?

    public init(backgroundColor: Color? = nil) {
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        ODSBorderedButtonLabel(configuration: configuration, backgroundColor: backgroundColor)
            .contentShape(Rectangle())
    }
}

// =====================
// MARK: PRIVATE HELPERS
// =====================

private struct ODSButtonLabel: View {
    let configuration: ButtonStyle.Configuration

    var body: some View {
        configuration.label
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
    }
}

private struct ODSBorderedButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let backgroundColor: Color?

    var body: some View {
        ODSButtonLabel(configuration: configuration)
            .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(style: StrokeStyle(lineWidth: 1.0)))
            .foregroundColor(isEnabled ? (backgroundColor ?? .primary) : ODSColor.grey200.color)
            .opacity(configuration.isPressed ? 0.2 : 1.0)
    }
}

private struct ODSFilledButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let backgroundColor: Color?

    var body: some View {
        ODSButtonLabel(configuration: configuration)
            .foregroundColor(isEnabled ? ODSColor.core_black_900.color : ODSColor.grey200.color)
            .background(isEnabled ? (backgroundColor ?? ODSColor.coreTheme.color) : ODSColor.grey200.color)
            .opacity(configuration.isPressed || !isEnabled ? 0.2 : 1.0)
            .cornerRadius(8.0)
    }
}
