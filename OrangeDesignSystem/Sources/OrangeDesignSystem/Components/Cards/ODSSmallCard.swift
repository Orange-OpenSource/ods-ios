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

public struct ODSSmallCard: View {

    let title: String
    let subtitle: String?
    let image: Image

    public init(title: String, subtitle: String? = nil, image: Image) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }

    public var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                Text(title)
                    .lineLimit(1)
                    .odsFont(.bodyBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle = subtitle {
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
        .shadow(radius: 8)
        .padding(.all, 8)
    }
}

#if DEBUG
struct SmallCardView_Previews: PreviewProvider {

    let columns = [
        GridItem(.adaptive(minimum: 10.0), spacing: 0, alignment: .topLeading),
    ]

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                Text("Card in Vertical grid")
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150.0), spacing: 0, alignment: .top)], spacing: 0) {
                    ODSSmallCard(title: "1 Title", image: Image("ods_empty", bundle: Bundle.ods))
                    ODSSmallCard(title: "2 Title", subtitle: "2 Subtitle", image: Image("ods_empty", bundle: Bundle.ods))
                    ODSSmallCard(title: "3 A long long title", subtitle: "3 A long long Subtitle", image: Image("ods_empty", bundle: Bundle.ods))
                    ODSSmallCard(title: "4 A long long Title", image: Image("ods_empty", bundle: Bundle.ods))
                }
                .padding(.bottom, ODSSpacing.m)

                Text("Card in content view")
                    .odsFont(.title1)
                    .frame(width: .infinity, alignment: .leading)
                    .padding(.bottom, ODSSpacing.m)

                ODSSmallCard(title: "Title 4", subtitle: "Subtitle 4", image: Image("ods_empty", bundle: Bundle.ods)) // .background(.yellow)
            }
            .padding(.horizontal, 16)
        }
    }
}
#endif
