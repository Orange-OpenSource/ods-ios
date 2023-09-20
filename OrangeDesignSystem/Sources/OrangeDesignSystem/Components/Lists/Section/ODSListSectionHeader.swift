////
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

public struct ODSListSectionHeader: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let description: String?
    let button: ODSButton?

    // =================
    // MARK: Initializer
    // =================

    public init(
         title: String,
         description: String? = nil
     ) {
         self.title = title
         self.description = description
         self.button = nil
     }

     public init(
         title: String,
         description: String? = nil,
         @ViewBuilder button: () -> ODSButton
     ) {
         self.title = title
         self.description = description
         self.button = button()
     }

     public var body: some View {
         HStack(alignment: .top) {
             VStack(alignment: .leading, spacing: ODSSpacing.m) {
                 Text(title)
                     .odsFont(.bodyBold)
                     .accessibilityAddTraits(.isHeader)
                 if let description = description {
                     Text(description)
                         .odsFont(.bodyRegular)
                 }
             }

             Spacer()
             if let button = button {
                 button
             }
         }
         .padding(.all, ODSSpacing.s)
         .foregroundColor(Color(UIColor.systemGray))
         .listRowInsets(EdgeInsets())
         .background(Color(UIColor.systemGroupedBackground))
     }
 }
