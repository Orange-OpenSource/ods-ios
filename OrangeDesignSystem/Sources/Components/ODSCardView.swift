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

import Combine
import SwiftUI

public struct ODSCardModel: Identifiable {
    public var title: String
    public let image: String
    public let subTitle: String?
    public let description: String?
    public let destination: AnyView?

    public init(title: String, image: String) {
        self.title = title
        self.image = image
        subTitle = nil
        description = nil
        destination = nil
    }

    public init(title: String, image: String, subTitle: String? = nil, description: String? = nil) {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
        destination = AnyView(Text(title))
    }

    public init<Destination>(title: String, image: String, subTitle: String? = nil, description: String? = nil, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
        self.destination = AnyView(destination())
    }

    public var id: String {
        title
    }

    public static let example = ODSCardModel(title: "Title", image: "empty", subTitle: "Subtitle", description: "Lorem ipsum dolor sit amet, at blandit nec tristique porttitor.")
    public static let exampleMultiline = ODSCardModel(title: "Et galisum fugiat ex omnis officia et iusto eius et animi consequuntur et distinctio magnam id autem exercitationem a sint quibusdam. Aut ipsa autem aut omnis architecto ex ratione provident eum placeat atque qui veniam quos est rerum molestiae.", image: "empty", subTitle: "Sed quasi illo in quidem consectetur sit consequatur voluptatibus sed adipisci fuga quo voluptatem similique non quidem magni! Et dolores libero ut voluptatem possimus ea minus necessitatibus qui totam culpa vel maxime distinctio id ullam dolor et optio velit", description: "Lorem ipsum dolor sit amet. In similique soluta et corrupti aperiam et ipsum quibusdam aut ducimus beatae aut aliquid perferendis qui sunt quam et dolor maxime. Est laudantium quod sit nihil possimus et quas voluptatem in fugit deserunt sit Quis eligendi aut deserunt voluptatum est quia dolor. Quasi odit et incidunt quis sit quia inventore ut repellat quam hic repellat veritatis est dolorem quia et expedita voluptas. Et internos molestiae ut tempora quod non facere nisi ad doloribus velit ad enim corporis qui molestias dolorum qui galisum velit.")
}

public struct ODSCardView: View {
    public let element: ODSCardModel

    public init(element: ODSCardModel) {
        self.element = element
    }

    public var body: some View {

        CardInnerView(element: element) {}
            .cornerRadius(10)
            .shadow(radius: 1)
    }
}

public struct CardViewCustom<ButtonContent>: View where ButtonContent: View {
    public let element: ODSCardModel

    @ViewBuilder var buttonContent: () -> ButtonContent

    public init(element: ODSCardModel, buttonContent: @escaping () -> ButtonContent) {
        self.element = element
        self.buttonContent = buttonContent
    }

    public var body: some View {

        CardInnerView(element: element) {
            buttonContent()
        }
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct CardInnerView<ButtonContent>: View where ButtonContent: View {
    let element: ODSCardModel
    @ViewBuilder var buttonContent: () -> ButtonContent

    @State private var translation = CGSize.zero

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            ZStack {
                Image(element.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(element.title)
                        .font(ODSFontStyle.bodyBold.font())
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                    if let subTitle = element.subTitle {
                        Text(subTitle)
                            .font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                    Spacer()
                    if let description = element.description {
                        HStack(spacing: 0) {
                            Text(description)
                                .font(ODSFontStyle.bodyRegular.font())
                                .foregroundColor(.primary)
                                .lineLimit(nil)
                            Spacer()
                        }
                    }
                    buttonContent()
                }.layoutPriority(100)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            ODSCardView(element: ODSCardModel.example)
            let sample2 = ODSCardModel(title: "titre", image: "img_about", subTitle: "desPlaceholer LabImaging Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging")
            ODSCardView(element: sample2)
                .frame(width: 160, height: 175)
        }
    }
}
#endif
