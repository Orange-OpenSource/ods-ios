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

import Foundation
import SwiftUI

struct SliderPage: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 5)
                ComponentDescription(text: "Sliders allow users to select a single value or a range of values by moving a handle along a horizontal track.")
                Anatomy(image: "SliderAnatomy", items: ["Container", "Active fill", "Track", "Handle", "Icon"])
                VariantsTitle()
                UnlabeledSlider()
                LabeledSlider()
                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))

        }.navigationTitle("Slider")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
    }
}

struct SliderPage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SliderPage()
                .preferredColorScheme($0)
        }
    }
}

struct Anatomy: View {

    var image: String?
    var items: [String]

    var body: some View {
        Text("Anatomy").odsFont(style: .title1)

        Image(image ?? "empty")
            .resizable()
            .scaledToFit()
            .padding([.leading, .trailing], 15)
        VStack(alignment: .leading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Text("\(index + 1). \(item)").odsFont(style: .callout)
            }
        }
    }
}

struct ComponentDescription: View {

    var text: String

    var body: some View {
        Text(text).odsFont(style: .bodyRegular)
    }
}

struct VariantsTitle: View {

    var body: some View {
        Text("Variants")
            .odsFont(style: .title1)
    }
}

struct UnlabeledSlider: View {

    @State private var value = 50.0

    var body: some View {
        Text("Unlabeled slider")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Slider(
                value: $value,
                in: 0 ... 100)
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
    }
}

struct LabeledSlider: View {

    @State private var value = 50.0

    var body: some View {

        Text("Labeled slider")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "speaker.wave.1.fill")
                Slider(
                    value: $value,
                    in: 0 ... 100,
                    step: 5)
                Image(systemName: "speaker.wave.3.fill")
            }
        }
    }
}
