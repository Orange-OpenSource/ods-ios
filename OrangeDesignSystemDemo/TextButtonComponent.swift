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

import OrangeDesignSystem
import SwiftUI

struct TextButtonComponentModel: Identifiable {
    let name: String
    let image: String
    let destination: AnyView?

    init<Destination>(name: String, image: String, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.name = name
        self.image = image
        self.destination = AnyView(destination())
    }

    init(name: String, image: String) {
        self.name = name
        self.image = image
        destination = AnyView(Text(name + " to be define"))
    }

    var id: String {
        name
    }
}

struct TextButtonComponent: View {
    let component: TextButtonComponentModel
    var body: some View {
        NavigationLink(destination: component.destination) {
            VStack(alignment: .leading, spacing: 0) {
                Image(component.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(component.name)
                    .font(ODSFontStyle.headline.font())
                    .frame(
                        maxWidth: .infinity,
                        alignment: .topLeading)
                    .padding()
                    .accentColor(Color(uiColor: .label))
            }
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(12)
        }
    }
}

struct TextButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        let component = TextButtonComponentModel(name: "Text", image: "Shape_button")
        ForEach(ColorScheme.allCases, id: \.self) {
            TextButtonComponent(component: component)
                .frame(width: 200)
                .preferredColorScheme($0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}
