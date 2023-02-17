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

import BottomSheet
import SwiftUI

// swiftlint:disable multiline_parameters_brackets vertical_parameter_alignment

extension View {
    public func odsBottomSheet<Content: View> (
        title: String,
        subtitle: String? = nil,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.modifier(ODSBottomSheetModifier(
                title: title,
                subtile: subtitle,
                icon: nil,
                bottomSheetSize: bottomSheetSize,
                content: content))
        }

    public func odsBottomSheet<Content: View> (
        title: String,
        icon: Image? = nil,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.modifier(ODSBottomSheetModifier(
                title: title,
                subtile: nil,
                icon: icon,
                bottomSheetSize: bottomSheetSize,
                content: content))
        }
}

private struct ODSBottomSheetModifier<ContentView>: ViewModifier where ContentView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: String
    private let subtitle: String?
    private let icon: Image?
    private let bottomSheetContent: () -> ContentView
    private var bottomSheetSize: Binding<ODSBottomSheetSize>
    @Environment(\.theme) private var theme
    @ObservedObject var sizeReader = BottomSheetSizesManager.shared

    // =================
    // MARK: Initializer
    // =================

    init(title: String,
                subtile: String? = nil,
                icon: Image? = nil,
                bottomSheetSize: Binding<ODSBottomSheetSize>,
                @ViewBuilder content: @escaping () -> ContentView) {
        self.title = title
        self.subtitle = subtile
        self.icon = icon
        self.bottomSheetContent = content
        self.bottomSheetSize = bottomSheetSize
    }

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .bottomSheet(
                    bottomSheetPosition: bottomSheetSize,
                    options: [.noBottomPosition,
                              .cornerRadius(10),
                              .shadow(),
                              .noDragIndicator,
                              .absolutePositionValue,
                              .background(AnyView(theme.componentColors.bottomSheetHeaderBackground))
                    ],
                    headerContent: {
                        HeaderView(title: title, subtitle: subtitle, icon: icon, bottomSheetSize: bottomSheetSize)
                            .background(.red)
                            .readSize { size in
                                sizeReader.contentViewHeight = reader.size.height
                                sizeReader.headerHeight = size.height + 16
                            }
                    },
                    mainContent: bottomSheetContent)
        }
    }
}

fileprivate class BottomSheetSizesManager: ObservableObject {
    static let shared: BottomSheetSizesManager = BottomSheetSizesManager()
    
    @Published var headerHeight: CGFloat
    @Published var contentViewHeight: CGFloat

    private init() {
        self.headerHeight = 0.0
        self.contentViewHeight = 0.0
    }
}

public enum ODSBottomSheetSize: CGFloat, CaseIterable {
    ///The state where the BottomSheet is hidden
    case hidden
    ///The state where the height of the BottomSheet is 12.5% and the `mainContent` is hidden
    case small = 0.125
    ///The state where the height of the BottomSheet is 40%
    case medium = 0.4
    ///The state where the height of the BottomSheet is 97.5%
    case large = 0.975

    static public var allCases: [ODSBottomSheetSize] = [.hidden, .small, .medium, .large]
    
    public var rawValue: Self.RawValue {
        switch self {
        case .hidden:
            return 0
        case .small:
            print("small: \(BottomSheetSizesManager.shared.headerHeight)")
            return BottomSheetSizesManager.shared.headerHeight
        case .medium:
            print("medium: \(BottomSheetSizesManager.shared.contentViewHeight / 2)")
            return BottomSheetSizesManager.shared.contentViewHeight / 2
        case .large:
            print("large: \(BottomSheetSizesManager.shared.contentViewHeight - BottomSheetSizesManager.shared.headerHeight - 10)")
            return BottomSheetSizesManager.shared.contentViewHeight - BottomSheetSizesManager.shared.headerHeight - 10
        }
    }
}
//
//// MARK: Button sheet with header and content
//
//public struct ODSBottomSheet<ContentView>: View where ContentView: View {
//
//    // =======================
//    // MARK: Stored Properties
//    // =======================
//
//    private let title: String
//    private let subtitle: String?
//    private let icon: Image?
//    private let mainContent: () -> ContentView
//
//    private var bottomSheetSize: Binding<ODSBottomSheetSize>
//    @Environment(\.theme) private var theme
//
//    // =================
//    // MARK: Initializer
//    // =================
//
//    public init(title: String,
//                subtile: String? = nil,
//                icon: Image? = nil,
//                bottomSheetSize: Binding<ODSBottomSheetSize>,
//                @ViewBuilder content: @escaping () -> ContentView) {
//        self.title = title
//        self.subtitle = subtile
//        self.icon = icon
//        self.mainContent = content
//        self.bottomSheetSize = bottomSheetSize
//    }
//
//    public var body: some View {
//        EmptyView()
//            .bottomSheet(
//                bottomSheetPosition: bottomSheetSize,
//                options: [BottomSheet.Options.noBottomPosition,
//                          .cornerRadius(10),
//                          .shadow(),
//                          .background(AnyView(theme.componentColors.bottomSheetHeaderBackground))
//                ],
//                headerContent: {
//                    HeaderView(title: title, subtitle: subtitle, icon: icon, bottomSheetSize: bottomSheetSize)
//                },
//                mainContent: mainContent)
//    }
//}

struct HeaderView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let subtitle: String?
    let icon: Image?
    var bottomSheetSize: Binding<ODSBottomSheetSize>

    // =================
    // MARK: Initializer
    // =================

    var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.xs) {
            icon?
                .resizable()
                .frame(width: 20.0, height: 20.0)

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
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
        .padding(.bottom, ODSSpacing.s)
        .onTapGesture {
            self.bottomSheetSize.wrappedValue = .small
        }
        .readSize { size in
            BottomSheetSizesManager.shared.headerHeight = size.height
        }
    }
}

#if DEBUG
//struct ODSBottomSheet_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ScrollView {
//            Text("Hello World!")
//                .odsBottomSheet(title: "Title", bottomSheetSize: ODSBottomSheetSize.large) {
//                    ScrollView {
//                        Text("This is the bottom sheet content")
//                    }
//                }
//        }
//
//    }
//}
//
#endif
