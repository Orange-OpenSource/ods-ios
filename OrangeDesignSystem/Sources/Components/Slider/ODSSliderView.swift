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

public struct ODSSlider: View {
    @Binding var value: Double
    public var range: ClosedRange<Double>
    var step: Double
    var minimumLabelView: AnyView?
    var maximumLabelView: AnyView?

    public init(value: Binding<Double>, range: ClosedRange<Double>, step: Double.Stride = 1) {
        _value = value
        self.range = range
        self.step = step
    }

    public init<MinimumLabelView, MaximumLabelView>(value: Binding<Double>, range: ClosedRange<Double>, step: Double.Stride = 1, @ViewBuilder minimumLabelView: () -> MinimumLabelView, @ViewBuilder maximumLabelView: () -> MaximumLabelView) where MinimumLabelView: View, MaximumLabelView: View {
        _value = value
        self.range = range
        self.step = step
        self.minimumLabelView = AnyView(minimumLabelView())
        self.maximumLabelView = AnyView(maximumLabelView())
    }

    public var body: some View {
        VStack {
            HStack(alignment: .center) {
                minimumLabelView
                GeometryReader { geometry in
                    Slider(
                        value: $value,
                        in: range,
                        step: step)
                        .gesture(DragGesture(minimumDistance: 0).onChanged { value in
                            let percent = min(max(0, Float(value.location.x / geometry.size.width * 1)), 1)
                            let newValue = self.range.lowerBound + round(Double(percent) * (self.range.upperBound - self.range.lowerBound))
                            let rounded = round(newValue / step) * step
                            self.$value.wrappedValue = rounded
                        })
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center)
                }
                maximumLabelView
            }
        }
    }
}

#if DEBUG
struct ODSSlider_Previews: PreviewProvider {

    static var previews: some View {

        VStack {
            ODSSlider(
                value: .constant(50),
                range: 0 ... 100.0)
                .padding([.leading, .trailing], 10)
        }
    }
} SliderP
#endif
