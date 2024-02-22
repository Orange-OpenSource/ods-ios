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

/// <a href="https://system.design.orange.com/0c1af118d/p/177496-empty-states/b/454547" target="_blank">Empty State</a>.
///
/// Display an empty state with a centered image followed by a title and an optional text.
/// A button can also be added.
///
public struct ODSEmptyStateView: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let title: Text
    private let text: Text?
    private let image: Image
    private let button: Button<Text>?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the about module.
    ///
    /// - Parameters:
    ///    - title: The title of the screen displayed below the image. For example "File is missing".
    ///    - text: Text displayed below the title.
    ///    - image: Image displayed centered horizontally in the view.
    ///    - button: The button to add below the text.
    ///
    public init(title: Text, 
                text: Text? = nil,
                image: Image = Image("il_yoga_man", bundle: Bundle.ods),
                button: Button<Text>? = nil) {
        self.title = title
        self.text = text
        self.image = image
        self.button = button
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: ODSSpacing.none) {

                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .horizontal], ODSSpacing.xxl)
                    .accessibilityHidden(true)

                title
                    .padding(.top, ODSSpacing.m)
                    .odsFont(.titleL)
                    .multilineTextAlignment(.center)

                text?
                    .padding(ODSSpacing.s)
                    .odsFont(.bodyM)
                    .multilineTextAlignment(.center)

                button?
                    .odsEmphasisButtonStyle(emphasis: .high)
                    .padding(.top, ODSSpacing.m)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
    }
}
