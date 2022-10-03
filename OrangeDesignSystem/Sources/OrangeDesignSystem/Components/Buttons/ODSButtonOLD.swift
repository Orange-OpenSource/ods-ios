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

////
//// MIT License
//// Copyright (c) 2021 Orange
//// Permission is hereby granted, free of charge, to any person obtaining a copy
//// of this software and associated documentation files (the  Software), to deal
//// in the Software without restriction, including without limitation the rights
//// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//// copies of the Software, and to permit persons to whom the Software is
//// furnished to do so, subject to the following conditions:
////
//// The above copyright notice and this permission notice shall be included in all
//// copies or substantial portions of the Software.
////
//// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//// SOFTWARE.
////
////
//
// import SwiftUI
//
//// =================
//// MARK: PUBLIC API
//// =================
//
//// MARK: Button configuration
//
// public struct ODSImageDescription {
//    let image: Image
//    let imageWidth: CGFloat
//    let imageHeight: CGFloat
//    let foregroundColor: Color
//
//    public init(image: Image, imageWidth: CGFloat, imageHeight: CGFloat, foregroundColor: Color = .primary) {
//        self.image = image
//        self.imageWidth = imageWidth
//        self.imageHeight = imageHeight
//        self.foregroundColor = foregroundColor
//    }
// }
//
//// MARK: Button label configuration
//
// public struct ODSGenericButtonContent: View {
//    let topText: String?
//    let bottomText: String?
//    let textColor: Color
//    let imageDescription: ODSImageDescription?
//    @Environment(\.isEnabled) var isEnabled
//
//    public init(imageDescription: ODSImageDescription? = nil, topText: String? = nil, bottomText: String? = nil, textColor: Color = .primary) {
//        self.imageDescription = imageDescription
//        self.topText = topText
//        self.bottomText = bottomText
//        self.textColor = textColor
//    }
//
//    public var body: some View {
//        HStack(alignment: .center) {
//            if let imageDescription = imageDescription {
//                imageDescription.image
//                    .renderingMode(.template)
//                    .resizable()
//                    .foregroundColor(imageDescription.foregroundColor)
//                    .frame(width: imageDescription.imageWidth, height: imageDescription.imageHeight)
//            }
//
//            VStack(alignment: imageDescription == nil ? .center : .leading) {
//                if let topText = topText {
//                    Text(topText)
//                        .odsFont(.bodyBold)
//                        .foregroundColor(isEnabled ? textColor : .primary)
//                }
//
//                if let bottomText = bottomText {
//                    Text(bottomText)
//                        .odsFont(.caption1Regular)
//                        .foregroundColor(isEnabled ? textColor : .primary)
//                }
//            }
//        }
//    }
// }
//
//// MARK: Main Button style
// public enum ButtonType {
//    case filled
//    case bordered
//
//    public var isFilled: Bool {
//        switch self {
//        case .filled: return true
//        case .bordered: return false
//        }
//    }
// }
