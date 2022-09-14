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

/// Model used to configure the `ODSSmallCard` card.
public struct ODSSmallCardModel: Identifiable {
    public let title: String
    public let subtitle: String?
    public let image: Image
    public let destination: AnyView?

    /// Initialization.
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - image: The  image to be displayed in the card.
    ///
    public init(title: String, subtitle: String? = nil, image: Image) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        destination = nil
    }

    /// Initialization with destination view if placed in grid.
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - image: The  image to be displayed in the card.
    ///  - destination: The destiantion view builder, if the small card is inserted into a grid using the `ODSGridsOfCards`.
    ///
    public init<Destination>(title: String, subtitle: String? = nil, image: Image, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.destination = AnyView(destination())
    }

    /// The identifier based on the title.
    public var id: String {
        title
    }
}

///
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// A small card is a card which can be added in two columns grid.
/// It contains an image and a title, and an optional subtitle placed below.
/// 
/// A destination view can be provided if the card is inserted into the `ODSGridOfCards`
/// to make it clickable and open the destination in native navigation.
///
public struct ODSSmallCard: View {

    let model: ODSSmallCardModel

    /// Initialization.
    ///
    /// - Parameter model: The model to configure the card.
    ///
    public init(model: ODSSmallCardModel) {
        self.model = model
    }

    public var body: some View {
        VStack {
            model.image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                Text(model.title)
                    .lineLimit(1)
                    .odsFont(.bodyBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle = model.subtitle {
                    Text(subtitle)
                        .lineLimit(1)
                        .odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
        }
        .background(ODSColor.componentBackground2.color)
        .cornerRadius(10)
        .shadow(radius: ODSSpacing.xs)
        .padding(.all, ODSSpacing.s)
    }
}

#if DEBUG
struct SmallCardView_Previews: PreviewProvider {

    static let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    static let gridModel = [
        ODSSmallCardModel(title: "1 Title", image: Image("ods_empty", bundle: Bundle.ods)),
        ODSSmallCardModel(title: "2 Title", subtitle: "2 Subtitle", image: Image("ods_empty", bundle: Bundle.ods)),
        ODSSmallCardModel(title: "3 A long long title", subtitle: "3 A long long Subtitle", image: Image("ods_empty", bundle: Bundle.ods)),
        ODSSmallCardModel(title: "4 A long long Title", image: Image("ods_empty", bundle: Bundle.ods)),
    ]

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {

                Text("Card in Vertical grid")
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                LazyVGrid(columns: SmallCardView_Previews.columns, spacing: ODSSpacing.none) {
                    ForEach(gridModel) { model in
                        ODSSmallCard(model: model)
                    }
                }
                .padding(.bottom, ODSSpacing.m)

                Text("Card in content view")
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                ODSSmallCard(model: ODSSmallCardModel(title: "Title 4", subtitle: "Subtitle 4", image: Image("ods_empty", bundle: Bundle.ods)))
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}
#endif
