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
import OrangeDesignSystem
import SwiftUI

struct ColorUsage: View {

    // MARK: - Body
    var body: some View {
        VStack {
            Spacer().frame(height: 10)
            Text("Usage")
                .odsFont(style: .title1)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {

                Text("It is important to use the iOS system background and label colours and as they are dynamic. They automatically change between the slightly darker base and slightly lighter elevated colours, in order to enhance perception of depth and layering.")

                Spacer().frame(height: 20)

                Text("Some colours are define with different tints that automatically switches. For the greys, you can use the Apple System Greys. For black and white texts, use the Apple Dynamic System Colors. For more information, see [Apple Color Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/).").accentColor(ODS.coreOrange)
            }
        }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
}
