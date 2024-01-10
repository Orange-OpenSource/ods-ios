//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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

    // =================
    // MARK: Initializer
    // =================

    /// Initialization.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///
    public init(title: Text, imageSource: ODSImage.Source, subtitle: Text? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: 0) {
            ODSImage(source: imageSource)
                .aspectRatio(contentMode: .fill)
                .accessibilityHidden(true)
                .frame(maxHeight: 100)
                .clipped()

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                title
                    .lineLimit(1)
                    .odsFont(.bodyLBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                subtitle?
                    .lineLimit(1)
                    .odsFont(.bodyLRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .accessibilityElement(children: .combine)
            .padding(.all, ODSSpacing.m)
        }
        .foregroundColor(.primary)
        .modifier(CardShadowModifier())
    }
}

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
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)))

                    ODSCardSmall(
                        title: Text("2 Title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                        subtitle: Text("2 Subtitle"))

                    ODSCardSmall(
                        title: Text("3 A long long title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                        subtitle: Text("3 A long long Subtitle"))

                    ODSCardSmall(
                        title: Text("4 A long long Title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)))
                }
                .padding(.bottom, ODSSpacing.m)

                Text("Card in content view")
                    .odsFont(.titleL)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                ODSCardSmall(
                    title: Text("Title 4"),
                    imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                    subtitle: Text("Subtitle 4"))
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}
#endif
