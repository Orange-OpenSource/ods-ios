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

// MARK: Button label configuration

public struct ODSButtonContent: View {

    let text: String
    let image: Image?

    public init(text: String, image: Image? = nil) {
        self.text = text
        self.image = image
    }

    public var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            image?
                .renderingMode(.template)
                .resizable()
                .frame(width: 18, height: 18)

            Text(text)
                .odsFont(.bodyBold)
        }.padding(.all, ODSSpacing.m)
    }
}

// MARK: Functional Button style

public struct ODSFunctionalButtonStyle: ButtonStyle {

    public enum FunctionType {
        case positive
        case negative
    }

    let functionType: FunctionType

    public init(functionType: FunctionType) {
        self.functionType = functionType
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        switch functionType {
        case .positive:
            return ODSFilledButtonLabel(configuration: configuration, backgroundColor: .green)
        case .negative:
            return ODSFilledButtonLabel(configuration: configuration, backgroundColor: .red)
        }
    }
}

//// MARK: Bordered Button style
//
// public struct ODSBorderedButtonStyle: ButtonStyle {
//    let borderColor: Color
//
//    public init(borderColor: Color = .primary) {
//        self.borderColor = borderColor
//    }
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        ODSBorderedButtonLabel(configuration: configuration, borderColor: borderColor)
//    }
// }
//
//// MARK: Main Button style
// public enum ButtonType {
//    case filled
//    case bordered
//
//    public var isFilled: Bool {
//        switch self {
//        case .filled: return true
//        case .bordered: return false
//        }
//    }
// }
//
// public struct ODSButtonStyle: ButtonStyle {
//    let borderColor: Color?
//    let backgroundColor: Color?
//    let buttonType: ButtonType
//
//    public init(borderColor: Color? = nil, backgroundColor: Color? = nil, buttonType: ButtonType = .filled) {
//        if let backgroundColor = backgroundColor {
//            self.backgroundColor = backgroundColor
//        } else {
//            self.backgroundColor = buttonType.isFilled ? ODS.coreOrange : nil
//        }
//        self.buttonType = buttonType
//        self.borderColor = borderColor
//    }
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        switch buttonType {
//        case .filled:
//            return AnyView(ODSFilledButtonLabel(configuration: configuration, backgroundColor: backgroundColor))
//        case .bordered:
//            return AnyView(ODSBorderedButtonLabel(configuration: configuration, borderColor: borderColor))
//        }
//    }
// }

// =====================
// MARK: PRIVATE HELPERS
// =====================

// private struct ODSBorderedButtonLabel: View {
//    @Environment(\.isEnabled) var isEnabled
//    let configuration: ButtonStyle.Configuration
//    let borderColor: Color?
//
//    var body: some View {
//        ODSButtonLabel(configuration: configuration)
//            .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(isEnabled ? (borderColor ?? .primary) : Color(.secondaryLabel), lineWidth: 1.0))
//            .opacity(configuration.isPressed ? 0.2 : (isEnabled ? 1.0 : 0.5))
//    }
// }

private struct ODSFilledButtonLabel: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: ButtonStyle.Configuration
    let backgroundColor: Color?

    var body: some View {
        configuration.label
            .background(backgroundColor ?? .primary)
            .opacity(configuration.isPressed || !isEnabled ? 0.3 : 1.0)
            .cornerRadius(8.0)
    }
}

#if DEBUG
struct ODSButtonContent_Previews: PreviewProvider {

    struct buttonsSample: View {
        var disable = true

        var body: some View {
            VStack {
                Button {} label: {
                    ODSButtonContent(text: "Take a tour")
                }
                .buttonStyle(ODSFunctionalButtonStyle(functionType: .positive))
                .disabled(disable)

                Button {} label: {
                    ODSButtonContent(text: "Take a tour", image: Image(systemName: "pencil.tip.crop.circle"))
                }
                .buttonStyle(ODSFunctionalButtonStyle(functionType: .positive))
                .disabled(disable)
            }
        }
    }

    static var previews: some View {
        VStack {
            buttonsSample(disable: false)
            buttonsSample(disable: true)
        }.preferredColorScheme(.light)

        VStack {
            buttonsSample(disable: false)
            buttonsSample(disable: true)
        }.preferredColorScheme(.dark)
    }
}
#endif
