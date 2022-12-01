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

struct SliderComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Sliders"
        image = Image("Slider")
        description =  "Sliders allow users to select a single value or a range of values by moving a handle along a horizontal track."
        
        variants = AnyView(SliderVartants())
    }
}

struct SliderVartants: View {
    var body: some View {
        UnlabeledSlider()
        LabeledSlider()
        SteppedSlider()
    }
}

struct UnlabeledSlider: View {

    @State private var value = 50.0
    let range = 0 ... 100.0

    var body: some View {
        Text("Unlabeled slider")
            .odsFont(.title2)
        VStack(alignment: .center) {
            ODSSlider(
                value: $value,
                range: range)
        }
        .padding(.horizontal, ODSSpacing.s)
    }
}

struct LabeledSlider: View {

    @State private var value = 80.0
    let range = 0 ... 100.0

    var body: some View {

        Text("Labeled slider").odsFont(.title2)
        Text("Value : \(Int(value))").odsFont(.bodyRegular).accessibilityHidden(true)
        VStack(alignment: .center) {
            ODSSlider(value: $value, range: range) {
                Image(systemName: "speaker.wave.1.fill").accessibilityHidden(true)
            } maximumLabelView: {
                Image(systemName: "speaker.wave.3.fill").accessibilityHidden(true)
            }
            .accessibilityLabel(Text("Volume"))
        }
        .padding([.leading, .trailing], ODSSpacing.s)
    }
}

struct SteppedSlider: View {

    @State private var value = 30.0
    let range = 0.0 ... 100.0
    let step = 10.0

    var body: some View {

        Text("Stepped slider").odsFont(.title2)
        Text("Value : \(Int(value))").odsFont(.bodyRegular).accessibilityHidden(true)

        VStack(alignment: .center) {
            ODSSlider(value: $value,
                      range: range,
                      step: step) {
                Text("0").accessibilityHidden(true)
            } maximumLabelView: {
                Text("100").accessibilityHidden(true)
            }
            .padding([.leading, .trailing], ODSSpacing.s)
        }
    }
}


#if DEBUG

struct SliderPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            List {
                SliderVartants()
            }
        }
    }
}
#endif
