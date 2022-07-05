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

// MARK: Button sheet with header and content
struct BottomSheet: View {
    @State var showContent: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                BottomSheedHeader(showContent: $showContent)
                    .background(Color(UIColor.systemGray6))

                if showContent {
                    BottomSheetContent()
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct BottomSheedHeader: View {

    @Binding var showContent: Bool

    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 55, height: 4, alignment: .center)
                .padding(.top, 8)
                .padding(.bottom, 4)

            Button {
                showContent.toggle()
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 16) {
                        let imageName = showContent ? "chevron.down" : "chevron.up"

                        Image(systemName: imageName)
                            .foregroundColor(.primary)
                            .accessibility(hidden: true)

                        Text("Settings")
                            .odsFont(style: .headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.all, 8)

                    Divider()
                }
            }
        }
    }
}

// MARK: Bottom Sheet - content for list
struct BottomSheetContent: View {

    @EnvironmentObject var listPageModel: ListPageModel

    var body: some View {
        VStack(spacing: 16) {
            ODSChipPicker(title: "Second line of text",
                          chips: listPageModel.secondLineOfTextChips,
                          type: .single($listPageModel.selectedSecondLineOfTextChip, allowZeroSelection: true))

            ODSChipPicker(title: "Leading",
                          chips: listPageModel.leadingImageChips,
                          type: .single($listPageModel.selectedLeadingImageChip, allowZeroSelection: true))

            ODSChipPicker(title: "Trailing",
                          chips: listPageModel.trailingImageChips,
                          type: .single($listPageModel.selectedTrailingImageChip, allowZeroSelection: true))
        }
        .padding(.vertical, 8)
    }
}
