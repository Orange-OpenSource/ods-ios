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


///
/// <a href="https://system.design.orange.com/0c1af118d/p/7559da-sliders/b/253eea" target="_blank">ODS Slider</a>.
///
/// Based on the native `Slider`, the `ODSSLider` offers to the user the possibility
/// to type direcly on the slider's track to get a value.
///
public struct ODSSlider<V, ValueLabel>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint, ValueLabel: View {
    @Binding var value: V
    public let range: ClosedRange<V>
    let step: V.Stride
    let minimumValueLabel: () -> ValueLabel
    let maximumValueLabel: () -> ValueLabel

    /// Creates an unlabeled slider to select a value from a given range, subject to a
    /// step increment.
    ///
    /// - Parameters:
    ///   - value: The selected value within `range`.
    ///   - range: The range of the valid values.
    ///   - step: The distance between each valid value. default 1
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `range`.
    ///
    public init(value: Binding<V>, range: ClosedRange<V>, step: V.Stride = 1) where ValueLabel == EmptyView {
        _value = value
        self.range = range
        self.step = step
        maximumValueLabel = {
            EmptyView()
        }
        minimumValueLabel = {
            EmptyView()
        }
    }

    /// Creates a slider to select a value from a given range, subject to a
    /// step increment. which displays the provided labels.
    ///
    /// - Parameters:
    ///   - value: The selected value within `range`.
    ///   - range: The range of the valid values.
    ///   - step: The distance between each valid value. default 1
    ///   - minimumValueLabel: A view that describes `range.lowerBound`.
    ///   - maximumValueLabel: A view that describes `range.lowerBound`.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `range`.
    ///
    public init(value: Binding<V>, range: ClosedRange<V>, step: V.Stride = 1, @ViewBuilder minimumLabelView: @escaping () -> ValueLabel, @ViewBuilder maximumLabelView: @escaping () -> ValueLabel) {
        _value = value
        self.range = range
        self.step = step
        minimumValueLabel = minimumLabelView
        maximumValueLabel = maximumLabelView
    }

    public var body: some View {
        VStack {
            HStack(alignment: .center) {
                
                minimumValueLabel()
                
                GeometryReader { geometry in
                    Slider(
                        value: $value,
                        in: range,
                        step: step)
                        .gesture(DragGesture(minimumDistance: 0).onChanged { value in
                            let percent = min(max(0, Float(value.location.x / geometry.size.width * 1)), 1)
                            let newValue = self.range.lowerBound + round(V(Double(percent)) * (self.range.upperBound - self.range.lowerBound))
                            let rounded = round(V.Stride(newValue) / step) * step
                            self.$value.wrappedValue = V(rounded)
                        })
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center
                        )
                }
                
                maximumValueLabel()
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
}

struct ODSSlider_Previews_with_label: PreviewProvider {

    static var previews: some View {

        VStack {
            ODSSlider(
                value: .constant(50),
                range: 0 ... 100.0) {
                    Image(systemName: "speaker.wave.1.fill")
                } maximumLabelView: {
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding([.leading, .trailing], 10)
        }
    }
}
#endif
