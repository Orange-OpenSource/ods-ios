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

///
/// <a href="https://system.design.orange.com/0c1af118d/p/278734-buttons-shape/b/536b5f" target="_blank">ODS Buttons</a>.
///
/// A button is an interactive element that enables the user to initiate an immediate action.
///
public struct ODSButton: View {
    public enum Emphasis: String, CaseIterable {
        case high
        case medium
        case low
        case lowest
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let text: Text
    private let image: Image?
    private let emphasis: Emphasis
    private let variableWidth: Bool
    private let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - emphasis: Controls the style of the button. Use `ODSButton.Emphasis.highest` for an highlighted button style. To get a bordered button use `ODSButton.Emphasis.medium` and get a text only use `ODSButton.Emphasis.low`.
    ///   - variableWidth: Defines the size of the button layout. Set to `true`, the size of the button is limited to the size of the text added by a padding round it. Set to `false` means button takes all available space horizontally.
    ///   - action: Will be called when the user clicks the button.
    ///
    public init(
        text: Text,
        image: Image? = nil,
        emphasis: Emphasis,
        variableWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.image = image
        self.emphasis = emphasis
        self.variableWidth = variableWidth
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Button {
            action()
        } label: {
            ODSButtonContent(text, image: image)
        }
        .odsEmphasisButtonStyle(emphasis: emphasis, fullWidth: !variableWidth)
    }
}

#if DEBUG
struct ODSButton_Previews: PreviewProvider {

    struct ButtonsSample: View {

        var body: some View {
            ScrollView {
                VStack {
                    ForEach(ODSButton.Emphasis.allCases, id: \.rawValue) { emphasis in
                        ODSButton(text: Text(emphasis.rawValue), emphasis: emphasis) {}
                        ODSButton(text: Text(emphasis.rawValue), emphasis: emphasis) {}.disabled(true)
                        ODSButton(text: Text(emphasis.rawValue), emphasis: emphasis) {}.disabled(true)
                        ODSButton(text: Text(emphasis.rawValue),
                                  image: Image(systemName: "pencil.tip.crop.circle"),
                                  emphasis: emphasis) {}
                        ODSButton(text: Text(emphasis.rawValue),
                                  image: Image(systemName: "pencil.tip.crop.circle"),
                                  emphasis: emphasis) {}.disabled(true)
                    }
                }
            }
        }
    }

    static var previews: some View {
        ButtonsSample()
            .preferredColorScheme(.light)

        ButtonsSample()
            .preferredColorScheme(.dark)
    }
}
#endif
