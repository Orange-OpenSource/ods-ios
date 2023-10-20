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

struct LeadingView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let element: ODSListItem.Leading
    let height: CGFloat
    let width: CGFloat = 44
    let wideWidth: CGFloat = 88

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch element {
        case .icon(let image):
            image.renderingMode(.template)
        case .circularImage(let source):
            ODSImage(source: source)
                .frame(width: width, height: height)
                .clipShape(Circle())
        case .squareImage(let source):
            ODSImage(source: source)
                .frame(width: width, height: height)
                .clipShape(Rectangle())
        case .wideImage(let source):
            ODSImage(source: source)
                .frame(width: wideWidth, height: height)
                .clipShape(Rectangle())
        }
    }
}
