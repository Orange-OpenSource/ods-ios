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
/// As image can be loaded from resources (sync) or
/// from url (Async), this desplays image accrding to the
/// source __ODSImage.Source__.
///
/// For Async image, until the image loads, the view displays a standard placeholder that fills the available space.
/// For more detail see __AsyncImage__.
///
public struct ODSImage: View {

    // ======================
    // MARK: Store Properties
    // ======================

    public enum Source {
        case image(Image)
        case asyncImage(URL, Image)
    }

    let source: Source

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        switch source {
        case let .asyncImage(url, placeHolder):
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                placeHolder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }

        case let .image(image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
