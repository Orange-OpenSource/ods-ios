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
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// A small card is a card which can be added in two columns grid.
/// It contains an image and a title, and an optional subtitle placed below.
///
public struct ODSCardSmall: View {

    private let title: Text
    private let subtitle: Text?
    private let imageSource: ODSImage.Source
    private let titleAccessibleLineLimit: Int?
    private let subtitleAccessibleLineLimit: Int?

    @Environment(\.sizeCategory) private var sizeCategory

    // =================
    // MARK: Initializer
    // =================

    /// Initialization.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the card,d efault set to `nil`
    ///  - titleAccessibleLineLimit: The line limit to apply to the title if size category is accessibility category, default set to `nil`
    ///  - subtitleAccessibleLineLimit: The line limit to apply to the subtitle if size category is accessibility category, default set to `nil`
    public init(title: Text, imageSource: ODSImage.Source, subtitle: Text? = nil, titleAccessibleLineLimit: Int? = nil, subtitleAccessibleLineLimit: Int? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.titleAccessibleLineLimit = titleAccessibleLineLimit
        self.subtitleAccessibleLineLimit = subtitleAccessibleLineLimit
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: 0) {
            ODSImage(source: imageSource)
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: 100)
                .clipped()
                .accessibilityRemoveTraits(.isImage)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                title
                    .lineLimit(sizeCategory.isAccessibilityCategory ? titleAccessibleLineLimit : 1)
                    .odsFont(.bodyLBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                subtitle?
                    .lineLimit(sizeCategory.isAccessibilityCategory ? subtitleAccessibleLineLimit : 1)
                    .odsFont(.bodyLRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .accessibilityElement(children: .combine)
            .padding(.all, ODSSpacing.m)
            .modifier(AccessibleMultilineTextAlignment())
        }
        .foregroundColor(.primary)
        .modifier(CardShadowModifier())
    }
}

// ===========================================
// MARK: - Accessible Multiline Text Alignment
// ===========================================

private struct AccessibleMultilineTextAlignment: ViewModifier {

    @Environment(\.sizeCategory) private var sizeCategory

    func body(content: Content) -> some View {
        if sizeCategory.isAccessibilityCategory {
            content.multilineTextAlignment(.leading)
        } else {
            content
        }
    }
}

// ========================
// MARK: - Preview Provider
// ========================

#if DEBUG
struct SmallCardView_Previews: PreviewProvider {

    static let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {

                Text("Card in Vertical grid")
                    .odsFont(.titleL)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                LazyVGrid(columns: SmallCardView_Previews.columns, spacing: ODSSpacing.none) {
                    ODSCardSmall(
                        title: Text("1 Title"),
                        imageSource: .image(Image("placeholder", bundle: Bundle.ods)))

                    ODSCardSmall(
                        title: Text("2 Title"),
                        imageSource: .image(Image("placeholder", bundle: Bundle.ods)),
                        subtitle: Text("2 Subtitle"))

                    ODSCardSmall(
                        title: Text("3 A long long title"),
                        imageSource: .image(Image("placeholder", bundle: Bundle.ods)),
                        subtitle: Text("3 A long long Subtitle"))

                    ODSCardSmall(
                        title: Text("4 A long long Title"),
                        imageSource: .image(Image("placeholder", bundle: Bundle.ods)))
                }
                .padding(.bottom, ODSSpacing.m)

                Text("Card in content view")
                    .odsFont(.titleL)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                ODSCardSmall(
                    title: Text("Title 4"),
                    imageSource: .image(Image("placeholder", bundle: Bundle.ods)),
                    subtitle: Text("Subtitle 4"))
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}
#endif
