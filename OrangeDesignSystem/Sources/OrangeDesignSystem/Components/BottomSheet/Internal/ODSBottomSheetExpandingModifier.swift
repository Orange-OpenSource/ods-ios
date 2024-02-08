//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
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
        subtitle: String? = nil,
        icon: Image? = nil,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> ContentView)
    {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        mainContent = content
        self.bottomSheetSize = bottomSheetSize
        bottomSheetPosition = self.bottomSheetSize.wrappedValue.position
    }

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .bottomSheet(
                bottomSheetPosition: $bottomSheetPosition,
                switchablePositions: ODSBottomSheetSize.positions,
                headerContent: {
                    BottomSheetHeader(title: title, subtitle: subtitle, icon: icon, applyRotation: false)
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
                mainContent: mainContent)
            .showDragIndicator(false)
            .enableAppleScrollBehavior(true)
            .enableContentDrag(true)
            .enableTapToDismiss(true)
            .onDismiss {
                bottomSheetPosition = ODSBottomSheetSize.small.position
            }
            .customBackground(background)
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
