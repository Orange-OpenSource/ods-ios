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

import Combine
import Foundation
import OrangeDesignSystem
import SwiftUI

struct TabBarPage: View {

    var body: some View {
        ScrollView {
            Image("Tab bar")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "A tab bar is a constantly available element which creates an overall navigation for users' experience.")
                VariantsTitle()
                TabBarVariant(nbItems: 2)
                TabBarVariant(nbItems: 3)
                TabBarVariant(nbItems: 4)
                TabBarVariant(nbItems: 5)
                Spacer().frame(height: 10)
            }
            .padding(EdgeInsets(top: ODSSpacing.none, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))
        }
        .background(ODSColor.primaryBackground.color)
    }
}

struct TabBarVariant: View {

    var nbItems: Int

    var body: some View {
        Text("\(nbItems) entries").odsFont(style: .title2)
        Image("TabBar-\(nbItems)-items")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
