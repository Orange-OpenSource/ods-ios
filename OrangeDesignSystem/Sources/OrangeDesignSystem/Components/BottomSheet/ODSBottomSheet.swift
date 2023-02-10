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

public enum ODSBottomSheetSize: Int, CaseIterable {
    case small = 0
    case medium
    case large
}

// MARK: Button sheet with header and content
public struct ODSBottomSheet<ContentView>: View where ContentView: View {

    private let contentView: () -> ContentView
    private let title: String
    private let subtitle: String?
    private let icon: Image?
    private let preferedSizes: [ODSBottomSheetSize]
    @State var headerHeight: CGFloat = 44

    public init(title: String,
                subtile: String? = nil,
                icon: Image? = nil,
                preferedSizes: [ODSBottomSheetSize] = [.large],
                @ViewBuilder contentView: @escaping () -> ContentView) {
        self.title = title
        self.subtitle = subtile
        self.icon = icon
        self.contentView = contentView
        self.preferedSizes = preferedSizes
    }

    public var body: some View {
        if #available(iOS 16.0, *) {
            content()
                .edgesIgnoringSafeArea(.all)
                .presentationDetents(presentationDetents)
                .presentationDragIndicator(.hidden)
        } else {
            content()
        }
    }

    @ViewBuilder func content() -> some View {
        VStack(spacing: ODSSpacing.none) {
            ODSBottomSheetHeader(title: title,
                                 subtitle: subtitle,
                                 icon: icon)
                .readSize { size in
                    print("size: \(size.height)")
                    headerHeight = size.height
                }
            contentView()
        }
        .cornerRadius(10)
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    var presentationDetents: Set<PresentationDetent> {
        Set(preferedSizes.map { size in
            switch size {
            case .large: return .large
            case .medium: return .medium
            case .small: return .height(headerHeight)
            }
        })
    }
}

struct ODSBottomSheetHeader: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let subtitle: String?
    let icon: Image?

    // ==================
    // MARK: Initializers
    // ==================

    var body: some View {
        ZStack(alignment: .top) {
            HStack(alignment: .center, spacing: ODSSpacing.xs) {
                icon?
                    .resizable()
                    .frame(width: 20.0, height: 20.0)

                VStack(alignment: .leading) {
                    Text(title)
                        .odsFont(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let subtitle = self.subtitle {
                        Text(subtitle)
                            .odsFont(.subhead)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }    
            }
            .padding(.all, ODSSpacing.m)

            RoundedRectangle(cornerRadius: 4)
                .frame(width: 55, height: 4, alignment: .top)
                .padding(.top, ODSSpacing.s)
        }
        .background(Color(UIColor.systemGray6))
    }
}

#if DEBUG
struct ODSBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ODSBottomSheet(title: "Title",
                       subtile: "Subtitle",
                       icon: Image(systemName:  "heart")) {
            ScrollView {
                Text("Hello world!")
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

//struct ODSBottomSheetHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ODSBottomSheetHeader(title: "Title", subtitle: "Subtitle")
//    }
//}
#endif
