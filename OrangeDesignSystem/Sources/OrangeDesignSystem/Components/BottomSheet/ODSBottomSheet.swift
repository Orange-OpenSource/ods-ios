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
        bottomSheetPosition: Binding<BottomSheetPosition>,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.modifier(ODSBottomSheetModifier(
                title: title,
                subtile: subtitle,
                icon: nil,
                bottomSheetSize: bottomSheetSize,
                bottomSheetPosition: bottomSheetPosition,
                content: content))
        }

    public func odsBottomSheet<Content: View> (
        title: String,
        icon: Image? = nil,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        bottomSheetPosition: Binding<BottomSheetPosition>,
        @ViewBuilder content: @escaping () -> Content) -> some View {
            self.modifier(ODSBottomSheetModifier(
                title: title,
                subtile: nil,
                icon: icon,
                bottomSheetSize: bottomSheetSize,
                bottomSheetPosition: bottomSheetPosition,
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
    private var bottomSheetPosition: Binding<BottomSheetPosition>
    @Environment(\.theme) private var theme

    // =================
    // MARK: Initializer
    // =================

    init(title: String,
         subtile: String? = nil,
         icon: Image? = nil,
         bottomSheetSize: Binding<ODSBottomSheetSize>,
         bottomSheetPosition: Binding<BottomSheetPosition>,
         @ViewBuilder content: @escaping () -> ContentView) {
        self.title = title
        self.subtitle = subtile
        self.icon = icon
        self.bottomSheetContent = content
        self.bottomSheetSize = bottomSheetSize
        self.bottomSheetPosition = bottomSheetPosition
    }

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .bottomSheet(bottomSheetPosition: bottomSheetPosition,
                         switchablePositions: [.dynamicBottom, .relative(0.5), .relative(0.9)],
//            .bottomSheet(
//                bottomSheetPosition: bottomSheetSize,
//                options: [.noBottomPosition,
//                          .cornerRadius(10),
//                          .dragIndicatorColor(Color(UIColor.label)),
//                          .shadow(),
//                          .background(AnyView(theme.componentColors.bottomSheetHeaderBackground))
//                ],
                headerContent: {
                    HeaderView(title: title, subtitle: subtitle, icon: icon, bottomSheetSize: bottomSheetSize)
                },
                mainContent: bottomSheetContent)
                .showDragIndicator(true)
    }
}

public enum ODSBottomSheetSize: CGFloat, CaseIterable {
    ///The state where the BottomSheet is hidden
    case hidden
    ///The state where the height of the BottomSheet is 10% and the `mainContent` is hidden
    case small = 0.10
    ///The state where the height of the BottomSheet is 40%
    case medium = 0.40
    ///The state where the height of the BottomSheet is 97.5%
    case large = 0.975
}

public struct HeaderView: View {

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

    public var body: some View {
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
