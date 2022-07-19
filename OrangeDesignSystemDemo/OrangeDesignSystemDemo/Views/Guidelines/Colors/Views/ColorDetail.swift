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

struct ColorDetail: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var phoneColorScheme: ColorScheme
    @EnvironmentObject var screenState: ScreenState

    let color: ODSColor

    var body: some View {
        ZStack {

            BackgroundBlurView().edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {

                Rectangle().fill(color.color(forScheme: screenState.colorScheme))
                    .frame(width: 300, height: 150)

                VStack(alignment: .leading, spacing: 3) {
                    Text(color.displayName(forScheme: self.screenState.colorScheme)).odsFont(.headline)
                    Text(color.rawValue).font(.system(.caption, design: .monospaced))
                    Text(color.rgb(forScheme: screenState.colorScheme).toString()).odsFont(.caption1Regular)
                    Text(color.hexa(forScheme: screenState.colorScheme)).odsFont(.caption1Regular)

                    Spacer().frame(height: 15)

                    Text("Usage").odsFont(.headline)
                    Text("Coming soon ...").odsFont(.caption1Regular)

                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15))
            }.background(Color(uiColor: UIColor.systemGray6))
                .cornerRadius(10)
        }.onTapGesture {
            dismiss()
        }
    }
}
