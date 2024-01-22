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

import SwiftUI

struct ODSBottomSheetStandardModifier<BottomSheetContent>: ViewModifier where BottomSheetContent: View {

    // =======================
    // MARK: Stored Properties
    // =======================
    let isOpen: Binding<Bool>
    let headerConfig: ODSBottomSheetStandardHeaderConfig
    @ViewBuilder let bottomSheetContent: () -> BottomSheetContent
    @State private var bottomSheetHeaderSize = CGSize()

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        ZStack {
            content
            ODSBottomSheetStandard(isOpen: isOpen, headerSize: $bottomSheetHeaderSize,
                                   headerConfig: headerConfig, content: bottomSheetContent)
        }
    }
}

/// Used to configure the header of the bottom sheet __ODSBottomSheetStandard__.
struct ODSBottomSheetStandardHeaderConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    fileprivate let title: String
    fileprivate let subtitle: String?
    fileprivate let icon: Image?
    fileprivate let animateIcon: Bool

    // ==================
    // MARK: Initializers
    // ==================

    /// Initilize the header of the __ODSBottomSheetStandard__ with title only.
    /// - Parameters:
    ///     - title: The title of the bottom sheet
    init(title: String) {
        self.init(title: title, subtitle: nil, icon: nil, animateIcon: false)
    }

    /// Initilize the header of the __ODSBottomSheetStandard__ with title and subtitle.
    ///  - Parameters:
    ///     - title: The title of the bottom sheet
    ///     - subtitle: The additional subtitle
    init(title: String, subtitle: String) {
        self.init(title: title, subtitle: subtitle, icon: nil, animateIcon: false)
    }

    /// Initilize the header of the __ODSBottomSheetStandard__ with title and subtitle.
    ///  - Parameters:
    ///     - title: The title of the bottom sheet
    ///     - icon: The additional icon added near to the title
    ///     - animateIcon: To animate (ration to 180 degrees) when sheet is opening.
    init(title: String, icon: Image, animateIcon: Bool = true) {
        self.init(title: title, subtitle: nil, icon: icon, animateIcon: animateIcon)
    }

    private init(title: String, subtitle: String?, icon: Image?, animateIcon: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.animateIcon = animateIcon
    }
}

/// The standard bottom sheet must be used only with a "simple, basic" content. If a more complex content must be added
/// prefer the __ odsBottomSheetExpanding__ modifiers.
///
/// The view of standard bottom sheet can be used out of the __odsBottomSheetStandard__ modifiers.
///
/// To do so, use it in a `ZStack` like this:
///
///     struct YourView: View {
///         @State var isShowingSheet: Bool = false
///         var body: some View {
///             ZStack {
///                 // Main content goes here.
///                 ScrollView {
///                     Text("Bottom sheet is \(isShowingSheet ? "Opened": "Closed")")
///                 }
///                 ODSBottomSheetStandard(isOpen: $isShowingSheet, headerConfig: ODSBottomSheetStandardHeaderConfig(title: "Customize")) {
///                     // Bottom sheet content goes here
///                 }
///             }
///         }
///     }
///
struct ODSBottomSheetStandard<Content: View>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let headerConfig: ODSBottomSheetStandardHeaderConfig
    private let content: Content
    private let isOpen: Binding<Bool>
    private let headerSize: Binding<CGSize>?

    // =================
    // MARK: Initializer
    // =================

    /// Initilize the bottom sheet view.
    ///
    ///  - Parameters:
    ///     - isOpen: A binding to a Boolean value that determines whether to open the sheet
    ///     - headerSize: A binding to a `CGSize` value that provide the size of the header.
    ///     Nice to get its height to add padding at the bottom of the main conent view to avoid bottom sheet to overlap it.
    ///     - headerConfig: The header configuration.
    ///     - content: A closure that returns the content of the bottom sheet.
    ///
    init(
        isOpen: Binding<Bool>,
        headerSize: Binding<CGSize>? = nil,
        headerConfig: ODSBottomSheetStandardHeaderConfig,
        @ViewBuilder content: @escaping () -> Content)
    {
        self.isOpen = isOpen
        self.headerSize = headerSize
        self.headerConfig = headerConfig
        self.content = content()
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Spacer()

            VStack(spacing: ODSSpacing.none) {
                BottomSheedHeader(title: headerConfig.title,
                                  subtitle: headerConfig.subtitle,
                                  icon: headerConfig.icon,
                                  applyRotation: applyRotation)
                    .onTapGesture {
                        withAnimation(Animation.linear) {
                            isOpen.wrappedValue.toggle()
                        }
                    }
                    .readSize { size in
                        headerSize?.wrappedValue = size
                    }

                if isOpen.wrappedValue {
                    content
                        .background(Color(UIColor.systemBackground))
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                }
            }
        }
    }

    // ==============
    // MARK: Helpers
    // ==============

    private var applyRotation: Bool {
        headerConfig.animateIcon && isOpen.wrappedValue
    }
}

#if DEBUG
struct StandardBottomSheetPreviewProvider_Previews: PreviewProvider {

    struct BottomSheet: View {
        @State var isOpen: Bool

        var body: some View {
            ODSBottomSheetStandard(isOpen: $isOpen,
                                   headerConfig: ODSBottomSheetStandardHeaderConfig(title: "Recipes", icon: Image(systemName: "chevron.up"))) {
                VStack {
                    ODSListItem(title: Text("Summer Salad"), leading: .icon(Image(systemName: "sun.max")))
                        .odsListItemStyle()
                    ODSListItem(title: Text("Bocoli Soup"), leading: .icon(Image(systemName: "heart")))
                        .odsListItemStyle()
                    ODSListItem(title: Text("Pesto farfalle"), leading: .icon(Image(systemName: "music.note")))
                        .odsListItemStyle()
                    ODSListItem(title: Text("Fig Sponge Cake"), leading: .icon(Image(systemName: "star")))
                        .odsListItemStyle()
                }
                .padding(.horizontal, 16)
            }
        }
    }

    static var previews: some View {
        BottomSheet(isOpen: true)
    }
}
#endif
