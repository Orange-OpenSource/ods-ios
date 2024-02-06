//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
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
    private let fullWidth: Bool
    private let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - emphasis: Controls the style of the button. Use `ODSButton.Emphasis.highest` for an highlighted button style.
    ///   To get a bordered button use `ODSButton.Emphasis.medium` and get a text only use `ODSButton.Emphasis.low`.
    ///   - fullWidth: Defines the size of the button layout. Set to `true` means button takes all available space horizontally.
    ///   Set to `false`, the size of the button is limited to the size of the text added by a padding round it.
    ///   - action: Will be called when the user clicks the button.
    ///
    public init(
        text: Text,
        image: Image? = nil,
        emphasis: Emphasis,
        fullWidth: Bool = false,
        action: @escaping () -> Void)
    {
        self.text = text
        self.image = image
        self.emphasis = emphasis
        self.fullWidth = fullWidth
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
        .odsEmphasisButtonStyle(emphasis: emphasis, fullWidth: fullWidth)
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
