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
    public let title: String
    public let image: String?
    public let subTitle: String?
    public let description: String?
    public let destination: AnyView?

    public init(title: String, image: String?, subTitle: String? = nil, description: String? = nil) {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
        destination = nil
    }

    public init<Destination>(title: String, image: String?, subTitle: String? = nil, description: String? = nil, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.title = title
        self.image = image
        self.subTitle = subTitle
        self.description = description
        self.destination = AnyView(destination())
    }
}

public struct ODSCardView: View {
    public let element: ODSCardModel

    public init(element: ODSCardModel) {
        self.element = element
    }

    var image: Image {
        if let image = element.image {
            return Image(image.isEmpty ? "ods_empty" : image,
                         bundle: image.isEmpty ? Bundle.ods : Bundle.main)
        } else {
            return Image("ods_empty", bundle: Bundle.ods)
        }
    }

    public var body: some View {

        let model = ODSCardImageFirstModel(title: element.title,
                                           subtitle: element.subTitle,
                                           image: image,
                                           supportingText: element.description)
        ODSCardImageFirst(model: model)
    }
}

extension ODSCardModel {

    public static let example = ODSCardModel(title: "Title", image: "", subTitle: "Subtitle", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.")
    public static let exampleMultiline = ODSCardModel(title: "Et galisum fugiat ex omnis officia et iusto eius et animi consequuntur et distinctio magnam id autem exercitationem a sint quibusdam. Aut ipsa autem aut omnis architecto ex ratione provident eum placeat atque qui veniam quos est rerum molestiae.", image: "", subTitle: "Sed quasi illo in quidem consectetur sit consequatur voluptatibus sed adipisci fuga quo voluptatem similique non quidem magni! Et dolores libero ut voluptatem possimus ea minus necessitatibus qui totam culpa vel maxime distinctio id ullam dolor et optio velit", description: "Lorem ipsum dolor sit amet. In similique soluta et corrupti aperiam et ipsum quibusdam aut ducimus beatae aut aliquid perferendis qui sunt quam et dolor maxime. Est laudantium quod sit nihil possimus et quas voluptatem in fugit deserunt sit Quis eligendi aut deserunt voluptatum est quia dolor. Quasi odit et incidunt quis sit quia inventore ut repellat quam hic repellat veritatis est dolorem quia et expedita voluptas. Et internos molestiae ut tempora quod non facere nisi ad doloribus velit ad enim corporis qui molestias dolorum qui galisum velit.")
}

#if DEBUG
struct CardView_Previews: PreviewProvider {

    static var previews: some View {
        ScrollView {
            ODSCardView(element: ODSCardModel.example).padding()
        }
    }
}
#endif
