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

import BottomSheet
import SwiftUI

struct ODSBottomSheetExpandingModifier<ContentView>: ViewModifier where ContentView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: String
    private let subtitle: String?
    private let icon: Image?
    private let mainContent: () -> ContentView
    private var bottomSheetSize: Binding<ODSBottomSheetSize>
    @State private var bottomSheetPosition: BottomSheetPosition

    // =================
    // MARK: Initializer
    // =================

    init(
        title: String,
        subtile: String? = nil,
        icon: Image? = nil,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> ContentView
    ) {
        self.title = title
        self.subtitle = subtile
        self.icon = icon
        self.mainContent = content
        self.bottomSheetSize = bottomSheetSize
        self.bottomSheetPosition = self.bottomSheetSize.wrappedValue.position
    }

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
        .bottomSheet(
            bottomSheetPosition: $bottomSheetPosition,
            switchablePositions: ODSBottomSheetSize.allCases.map { $0.position },
            headerContent: {
                BottomSheedHeader(title: title, subtitle: subtitle, icon: icon, applyRotation: false)
                    .onTapGesture {
                        switch self.bottomSheetSize.wrappedValue {
                        case .small:
                            self.bottomSheetPosition = ODSBottomSheetSize.medium.position
                        case .medium:
                            self.bottomSheetPosition = ODSBottomSheetSize.large.position
                        case .large:
                            self.bottomSheetPosition = ODSBottomSheetSize.small.position
                        default:
                             break
                        }
                    }
            },
            mainContent: mainContent
        )
        .showDragIndicator(false)
        .enableAppleScrollBehavior(true)
        .enableContentDrag(true)
        .enableTapToDismiss(true)
        .onDismiss {
            bottomSheetPosition = ODSBottomSheetSize.small.position
        }
        .customBackground(self.background)
        .onChange(of: bottomSheetPosition) { newValue in
            bottomSheetSize.wrappedValue = ODSBottomSheetSize(from: newValue)
        }

    }

    // =====================
    // MARK: Private Helpers
    // =====================

    @ViewBuilder
    private var background: some View {
        Color(.clear)
    }
}
