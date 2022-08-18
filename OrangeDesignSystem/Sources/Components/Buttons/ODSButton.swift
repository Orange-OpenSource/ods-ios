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
    @Environment(\.isEnabled) var isEnabled

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
                        .odsFont(.bodyBold)
                        .foregroundColor(isEnabled ? textColor : .primary)
                }

                if let bottomText = bottomText {
                    Text(bottomText)
                        .odsFont(.caption1Regular)
                        .foregroundColor(isEnabled ? textColor : .primary)
                }
            }
        }
    }
}

// MARK: Filled Button style

public struct ODSFilledButtonStyle: ButtonStyle {
    let backgroundColor: Color

    public init(backgroundColor: Color = odsCurrentTheme.colors.bottomNavigationBarContentSelected) {
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        return ODSFilledButtonLabel(configuration: configuration, backgroundColor: backgroundColor)
    }
}

// MARK: Bordered Button style

public struct ODSBorderedButtonStyle: ButtonStyle {
    let borderColor: Color

    public init(borderColor: Color = .primary) {
        self.borderColor = borderColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        ODSBorderedButtonLabel(configuration: configuration, borderColor: borderColor)
    }
}

// MARK: Main Button style
public enum ButtonType {
    case filled
    case bordered

    public var isFilled: Bool {
        switch self {
        case .filled: return true
        case .bordered: return false
        }
    }
}

public struct ODSButtonStyle: ButtonStyle {
    let borderColor: Color?
    let backgroundColor: Color?
    let buttonType: ButtonType

    public init(borderColor: Color? = nil, backgroundColor: Color? = nil, buttonType: ButtonType = .filled) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = buttonType.isFilled ? odsCurrentTheme.colors.bottomNavigationBarContentSelected : nil
        }
        self.buttonType = buttonType
        self.borderColor = borderColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        switch buttonType {
        case .filled:
            return AnyView(ODSFilledButtonLabel(configuration: configuration, backgroundColor: backgroundColor))
        case .bordered:
            return AnyView(ODSBorderedButtonLabel(configuration: configuration, borderColor: borderColor))
        }
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
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
    }
}

private struct ODSBorderedButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let borderColor: Color?

    var body: some View {
        ODSButtonLabel(configuration: configuration)
            .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(isEnabled ? (borderColor ?? .primary) : Color(.secondaryLabel), lineWidth: 1.0))
            .opacity(configuration.isPressed ? 0.2 : (isEnabled ? 1.0 : 0.5))
    }
}

private struct ODSFilledButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let backgroundColor: Color?

    var body: some View {
        ODSButtonLabel(configuration: configuration)
            .background(backgroundColor ?? .primary)
            .opacity(configuration.isPressed || !isEnabled ? 0.3 : 1.0)
            .cornerRadius(8.0)
    }
}
