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

public struct SliderOnTrackModifier<V>: ViewModifier where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
    var value: Binding<V>
    var range: ClosedRange<V>
    var step: V?

    public init(value: Binding<V>, range: ClosedRange<V>, step: V? = nil) {
        self.range = range
        self.value = value
        self.step = step
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .center) {
            GeometryReader { geometry in
                content
                    .gesture(DragGesture(minimumDistance: 0).onChanged { value in
                        let percent = min(max(0, Float(value.location.x / geometry.size.width * 1)), 1)
                        let newValue = self.range.lowerBound + round(V(Double(percent)) * (self.range.upperBound - self.range.lowerBound))
                        self.value.wrappedValue = newValue
                    })
            }
        }
    }
}

public struct ODSSlider: View {
    @Binding var value: Double
    public var range: ClosedRange<Double>
    var step: Double = 1.0

    public init(value: Binding<Double>, range: ClosedRange<Double>) {
        self.range = range
        _value = value
    }

    public init(value: Binding<Double>, range: ClosedRange<Double>, step: Double = 1.0) {
        self.range = range
        self.step = step
        _value = value
    }

    public var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geometry in
                Slider(
                    value: $value,
                    in: range,
                    step: step) {
                        Text("Value")
                    } minimumValueLabel: {
                        Text("  0")
                    } maximumValueLabel: {
                        Text("100")
                    }
                    .gesture(DragGesture(minimumDistance: 0).onChanged { value in
                        let percent = min(max(0, Float(value.location.x / geometry.size.width * 1)), 1)
                        let newValue = self.range.lowerBound + round(Double(percent) * (self.range.upperBound - self.range.lowerBound))
                        self.$value.wrappedValue = newValue
                    })
            }
        }
    }
}

// public struct ODSSlider2 : View {
//    @State private var  value = 50.0
//    var range: ClosedRange<Double> = 0 ... 100
//    var step: Double = 1.0
//
//    var body: some View {
//            Text("Unlabeled slider")
//                .odsFont(style: .title2)
//            VStack(alignment: .center) {
//                    GeometryReader { geometry in
//                            Slider(
//                                value: $value,
//                                in: range,
//                                step: step)
//                                .gesture(DragGesture(minimumDistance: 0).onEnded { value in
//                                        let percent = min(max(0, Float(value.location.x / geometry.size.width * 1)), 1)
//                                        let newValue = self.range.lowerBound + round(Double(percent) * (self.range.upperBound - self.range.lowerBound))
//                                        self.$value.wrappedValue = newValue
//                                    })
//                        }.padding([.leading, .trailing], 45)
//                }
//        }
// }
