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
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The source of the image.
    ///  - subtitle: The optional subtitle.
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
                    .odsFont(.bodyBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                subtitle?
                    .lineLimit(1)
                    .odsFont(.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
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
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                LazyVGrid(columns: SmallCardView_Previews.columns, spacing: ODSSpacing.none) {
                    ODSCardSmall(
                        title: Text("1 Title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods))
                    )

                    ODSCardSmall(
                        title: Text("2 Title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                        subtitle: Text("2 Subtitle")
                    )

                    ODSCardSmall(
                        title: Text("3 A long long title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                        subtitle: Text("3 A long long Subtitle")
                    )

                    ODSCardSmall(
                        title: Text("4 A long long Title"),
                        imageSource: .image(Image("ods_empty", bundle: Bundle.ods))
                    )
                }
                .padding(.bottom, ODSSpacing.m)

                Text("Card in content view")
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                ODSCardSmall(
                    title: Text("Title 4"),
                    imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
                    subtitle: Text("Subtitle 4")
                )
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}
#endif
