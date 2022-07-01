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

public struct ODSCardModel {
    public var title: String
    public var image: String
    public var subTitle: String?
    public var description: String?
    public var destination: AnyView?

    public init(title: String, image: String, subTitle: String? = nil, description: String? = nil) {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
    }

    public init<Destination>(title: String, image: String, subTitle: String? = nil, description: String? = nil, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
        self.destination = AnyView(destination())
    }

    public static let example = ODSCardModel(title: "Title", image: "", subTitle: "Subtitle", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.")
    public static let exampleMultiline = ODSCardModel(title: "Et galisum fugiat ex omnis officia et iusto eius et animi consequuntur et distinctio magnam id autem exercitationem a sint quibusdam. Aut ipsa autem aut omnis architecto ex ratione provident eum placeat atque qui veniam quos est rerum molestiae.", image: "", subTitle: "Sed quasi illo in quidem consectetur sit consequatur voluptatibus sed adipisci fuga quo voluptatem similique non quidem magni! Et dolores libero ut voluptatem possimus ea minus necessitatibus qui totam culpa vel maxime distinctio id ullam dolor et optio velit", description: "Lorem ipsum dolor sit amet. In similique soluta et corrupti aperiam et ipsum quibusdam aut ducimus beatae aut aliquid perferendis qui sunt quam et dolor maxime. Est laudantium quod sit nihil possimus et quas voluptatem in fugit deserunt sit Quis eligendi aut deserunt voluptatum est quia dolor. Quasi odit et incidunt quis sit quia inventore ut repellat quam hic repellat veritatis est dolorem quia et expedita voluptas. Et internos molestiae ut tempora quod non facere nisi ad doloribus velit ad enim corporis qui molestias dolorum qui galisum velit.")
}

public struct ODSCardView: View {
    public let element: ODSCardModel

    public init(element: ODSCardModel) {
        self.element = element
    }

    public var body: some View {

        CardInnerView(element: element) {}
            .cornerRadius(10)
            .shadow(radius: 8)
    }
}

public struct CardViewCustom<ButtonContent>: View where ButtonContent: View {
    public var element: ODSCardModel

    private var buttonContent: () -> ButtonContent

    public init(element: ODSCardModel, @ViewBuilder buttonContent: @escaping () -> ButtonContent) {
        self.element = element
        self.buttonContent = buttonContent
    }

    public var body: some View {

        CardInnerView(element: element) {
            buttonContent()
        }
        .cornerRadius(10)
        .shadow(radius: 12)
    }
}

struct CardInnerView<ButtonContent>: View where ButtonContent: View {
    let element: ODSCardModel
    @ViewBuilder var buttonContent: () -> ButtonContent

    @State private var translation = CGSize.zero

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Image(element.image.isEmpty ? "ods_empty" : element.image,
                  bundle: element.image.isEmpty ? Bundle.ods : Bundle.main)
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 5) {
                Text(element.title)
                    .font(ODSFontStyle.bodyBold.font())
                if let subTitle = element.subTitle, !subTitle.isEmpty {
                    Text(subTitle)
                }
                if let description = element.description, !description.isEmpty {
                    Text(description).padding(.top)
                }
                buttonContent().padding(.top)
            }
            .layoutPriority(100)
            .font(ODSFontStyle.bodyRegular.font())
            .foregroundColor(.primary)
            .padding()
        }.background(Color(UIColor.systemBackground))
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CardViewCustom(element: ODSCardModel.example) {
                    Button {} label: {
                        ODSGenericButtonContent(topText: "Button", textColor: ODSColor.coreBlack.color)
                    }
                    .buttonStyle(ODSFilledButtonStyle())
                }.padding()
                ODSCardView(element: ODSCardModel.example).padding()
            }
        }
    }
}
#endif
