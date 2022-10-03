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

/// Define emphasis buttons
public struct ODSButton: View {
    public enum Emphasis: String, CaseIterable {
        case heighest
        case heigh
        case medium
        case low
    }

    let text: LocalizedStringKey
    let image: Image?
    let emphasis: Emphasis
    let largeLayout: Bool
    let action: () -> Void

    public init(text: LocalizedStringKey,
                image: Image? = nil,
                emphasis: Emphasis,
                largeLayout: Bool = false,
                action: @escaping () -> Void)
    {
        self.text = text
        self.image = image
        self.emphasis = emphasis
        self.largeLayout = largeLayout
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            ODSButtonContent(text: text, image: image, largeLayout: largeLayout)
        }
        .modifier(ODSButtonStyleModifier(emphasis: emphasis))
    }
}

struct ODSButtonStyleModifier: ViewModifier {
    let emphasis: ODSButton.Emphasis

    @ViewBuilder func body(content: Content) -> some View {
        switch emphasis {
        case .heighest:
            let style = ODSShapedButtonStyle(shapeType: .filled,
                                             foregroundColor: Color.black,
                                             backgroundColor: ODSColor.coreOrange.color)
            content.buttonStyle(style)
        case .heigh:
            let style = ODSShapedButtonStyle(shapeType: .filled,
                                             foregroundColor: Color(UIColor.systemBackground),
                                             backgroundColor: Color(UIColor.label))
            content.buttonStyle(style)
        case .medium:
            let style = ODSShapedButtonStyle(shapeType: .bordered,
                                             foregroundColor: Color(UIColor.label),
                                             backgroundColor: Color.clear)
            content.buttonStyle(style)
        case .low:
            content
        }
    }
}

#if DEBUG
struct ODSButton_Previews: PreviewProvider {

    struct buttonsSample: View {

        var body: some View {
            ScrollView {
                VStack {
                    ForEach(ODSButton.Emphasis.allCases, id: \.rawValue) { emphasis in
                        ODSButton(text: LocalizedStringKey(emphasis.rawValue),
                                  emphasis: emphasis) {}
                        ODSButton(text: LocalizedStringKey(emphasis.rawValue),
                                  emphasis: emphasis) {}.disabled(true)

                        ODSButton(text: LocalizedStringKey(emphasis.rawValue),
                                  image: Image(systemName: "pencil.tip.crop.circle"),
                                  emphasis: emphasis) {}
                        ODSButton(text: LocalizedStringKey(emphasis.rawValue),
                                  image: Image(systemName: "pencil.tip.crop.circle"),
                                  emphasis: emphasis) {}.disabled(true)
                    }
                }
            }
        }
    }

    static var previews: some View {
        buttonsSample()
            .preferredColorScheme(.light)

        buttonsSample()
            .preferredColorScheme(.dark)
    }
}
#endif
