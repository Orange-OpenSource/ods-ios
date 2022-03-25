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

public struct ODSCard<Content>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ScaledMetric private var borderWidth: Double = ODSDim.ODSCard.borderWidth
    @ScaledMetric private var borderShadowWidth: Double = ODSDim.ODSCard.borderShadowWidth

    private let borderColor: Color
    private let backgroundColor: Color

    private let content: () -> Content

    // ==================
    // MARK: Initializers
    // ==================

    public init(borderColor: Color = ODSDim.ODSCard.borderColor, backgroundColor: Color = ODSColor.coreTheme.color, @ViewBuilder content: @escaping () -> Content) {
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.content = content
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        content()
            .fullWidthFrame()
            // .padding(ODSDim.ODSSpacing.regular)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(color: ODSColor.grey600.color, radius: 1)
    }
}

// MARK: -

public struct CardComplexContent<TopContent, BottomContent>: View where TopContent: View, BottomContent: View {

    @ViewBuilder var topContent: () -> TopContent
    @ViewBuilder var bottomContent: () -> BottomContent

    // ==================
    // MARK: Initializers
    // ==================

    /* public init(topContent: () -> TopContent, bottomContent: () -> BottomContent ) {
         self.topContent = topContent
         self.bottomContent = bottomContent
     }*/

    public init(topContent: @escaping () -> TopContent, bottomContent: @escaping () -> BottomContent) {
        self.topContent = topContent
        self.bottomContent = bottomContent
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: 0) {
            topContent()
            bottomContent()
            //    .padding(ODSDim.ODSSpacing.regular)
        }.padding()
    }
}

// MARK: -

private struct CardButtonStyle: ButtonStyle {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.canBeHighlighted) private var canBeHighlighted

    let backgroundColor: Color

    // ==========================
    // MARK: ButtonStyle Protocol
    // ==========================

    func makeBody(configuration: Self.Configuration) -> some View {
        let borderColor = configuration.isPressed && canBeHighlighted ? ODSColor.coreOrange.color : ODSDim.ODSCard.borderColor
        ODSCard(borderColor: borderColor, backgroundColor: backgroundColor) {
            if canBeHighlighted {
                configuration.label
            } else {
                configuration.label.foregroundColor(ODSColor.grey200.color)
            }
        }
    }
}

// MARK: -

extension View {

    // =========
    // MARK: API
    // =========

    func cardButtonStyle() -> some View {
        buttonStyle(CardButtonStyle(backgroundColor: ODSColor.coreTheme.color))
    }
}

// MARK: -

struct Card_Previews: PreviewProvider {

    static var previews: some View {
        VStack(alignment: .leading, spacing: ODSDim.ODSSpacing.regular) {
            withoutLinks
            withLinks
        }
    }

    private static var withoutLinks: some View {
        Group {
            Text("Sans liens :")
            ODSCard {
                Text("Test2")
                    .padding()
            }.padding()

            ODSCard {
                CardComplexContent {
                    Image("img_about", bundle: Bundle.bundle)
                        .centerCropped()
                        .frame(minHeight: 90, maxHeight: 190)

                } bottomContent: {
                    VStack(alignment: .leading) {
                        Text("With image").fullWidthFrame()
                        Text("Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging")
                            .fullWidthFrame()
                            .multilineTextAlignment(.leading)

                        Button {
                            print("Action")
                        } label: {
                            ODSGenericButtonContent(topText: "Added to Siri", textColor: ODSColor.core_black_900.color)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(ODSFilledButtonStyle())
                        .padding(.horizontal, ODSDim.padding)
                    }
                }
            }.padding()

            ODSCard {
                CardComplexContent {
                    rectangle()
                } bottomContent: {
                    rectangle(color: ODSColor.functional_alert_100.color)
                }
            }.padding()
        }
    }

    private static var withLinks: some View {
        Group {
            Text("Avec des liens :")
            Button {
                // empty
            } label: {
                Text("Ctest")
            }
        }
        .cardButtonStyle()
    }

    private static func rectangle(color: Color = ODSColor.supportingYellow200.color) -> some View {
        Rectangle()
            .foregroundColor(color)
            .frame(height: 30)
    }
}
