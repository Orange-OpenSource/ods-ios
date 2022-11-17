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

/// A banner displays an important message which requires an
/// action to be dismissed.
///
public struct ODSBanner: View {
    
    let text: LocalizedStringKey
    let image: Image?
    let button1: ODSButton?
    let button2: ODSButton?
    
    /// Initialize the banner.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - button1: The first button.
    ///   - button2: The second button.
    ///
    /// - Remarks: The default low emphasis is automatically applied on buttons.
    ///
    public init(text: LocalizedStringKey,
                image: Image? = nil,
                button1: ODSButton? = nil,
                button2: ODSButton? = nil)
    {
        self.text = text
        self.image = image
        self.button1 = button1
        self.button2 = button2
    }
    
    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: ODSSpacing.m) {
            HStack(spacing: ODSSpacing.s) {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40.0, height: 40.0, alignment: .center)
                    .clipShape(Circle())

                Text(text).odsFont(.subhead)
            }

            if button1 != nil || button2 != nil {
                HStack(spacing: ODSSpacing.s) {
                    Spacer()
                    button1?.modifier(ODSButtonStyleModifier(emphasis: .low))
                    button2?.modifier(ODSButtonStyleModifier(emphasis: .low))
                }
            }
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}

#if DEBUG
struct ODSBanner_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ODSBanner(text: "Title",
                      image: Image("ods_empty", bundle: Bundle.ods))
                .preferredColorScheme($0)
        }
    }
}
#endif
