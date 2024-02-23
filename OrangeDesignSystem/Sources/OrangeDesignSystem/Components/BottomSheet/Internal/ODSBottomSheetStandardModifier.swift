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

// ==========================================
// MARK: - ODS Bottom Sheet Standard Modifier
// ==========================================

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
            ODSBottomSheetStandard(isOpen: isOpen,
                                   headerSize: $bottomSheetHeaderSize,
                                   headerConfig: headerConfig,
                                   content: bottomSheetContent)
        }
    }
}

// ===============================================
// MARK: - ODS Bottom Sheet Standard Header Config
// ===============================================

/// Used to configure the header of the bottom sheet __ODSBottomSheetStandard__.
struct ODSBottomSheetStandardHeaderConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    fileprivate let title: String
    fileprivate let subtitle: String?
    fileprivate let stateLabels: AccessibilityStatesValues?
    fileprivate let stateHints: AccessibilityStatesValues?
    fileprivate let icon: Image?
    fileprivate let animateIcon: Bool

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the header of the __ODSBottomSheetStandard__ with title only.
    /// - Parameter title: The title of the bottom sheet
    init(title: String) {
        self.init(title: title,
                  subtitle: nil,
                  stateLabels: nil,
                  stateHints: nil,
                  icon: nil,
                  animateIcon: false)
    }

    /// Initializes the header of the __ODSBottomSheetStandard__ with title and subtitle.
    ///  - Parameters:
    ///     - title: The title of the bottom sheet
    ///     - subtitle: The additional subtitle
    init(title: String, subtitle: String) {
        self.init(title: title,
                  subtitle: subtitle,
                  stateLabels: nil,
                  stateHints: nil,
                  icon: nil,
                  animateIcon: false)
    }

    /// Initializes the header of the __ODSBottomSheetStandard__ with title and icon.
    ///  - Parameters:
    ///     - title: The title of the bottom sheet
    ///     - icon: The additional icon added near to the title
    ///     - animateIcon: To animate (ration to 180 degrees) when sheet is opening.
    init(title: String, icon: Image, animateIcon: Bool = true) {
        self.init(title: title,
                  subtitle: nil,
                  stateLabels: nil,
                  stateHints: nil,
                  icon: icon,
                  animateIcon: animateIcon)
    }

    /// Initializes the header of the __ODSBottomSheetStandard__ with title, subtitle, icon and accessibility values.
    ///  - Parameters:
    ///     - title: The title of the bottom sheet
    ///     - subtitle: The additional subtitle, optional, default set to nil
    ///     - stateLabels: The accessibility labels to use for opened and closed states
    ///     - stateHints: The accessibility hints to use for opened and closed states
    ///     - icon: The additional icon added near to the title, optional, default set to nil
    ///     - animateIcon: To animate (ratio to 180 degrees) when sheet is opening, default set to false
    init(title: String,
         subtitle: String? = nil,
         stateLabels: AccessibilityStatesValues?,
         stateHints: AccessibilityStatesValues?,
         icon: Image? = nil,
         animateIcon: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.stateLabels = stateLabels
        self.stateHints = stateHints
        self.icon = icon
        self.animateIcon = animateIcon
    }
}

// =================================
// MARK: - ODS Bottom Sheet Standard
// =================================

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

    private let isOpen: Binding<Bool>
    private let headerSize: Binding<CGSize>?
    private let headerConfig: ODSBottomSheetStandardHeaderConfig
    private let content: Content

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
                BottomSheetHeader(title: headerConfig.title,
                                  subtitle: headerConfig.subtitle,
                                  icon: headerConfig.icon,
                                  applyRotation: applyRotation)
                .modifier(AccessibilityValuesModifier(headerConfig, isOpen))
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
            .accessibilityElement(children: .contain)
        }
    }

    // ==============
    // MARK: Helpers
    // ==============

    private var applyRotation: Bool {
        headerConfig.animateIcon && isOpen.wrappedValue
    }
}

// =====================================
// MARK: - Accessibility Values Modifier
// =====================================

private struct AccessibilityValuesModifier: ViewModifier {

    private let labels: AccessibilityStatesValues?
    private let hints: AccessibilityStatesValues?
    private let isOpen: Binding<Bool>

    init(_ configuration: ODSBottomSheetStandardHeaderConfig, _ isOpen: Binding<Bool>) {
        labels = configuration.stateLabels
        hints = configuration.stateHints
        self.isOpen = isOpen
#if DEBUG
        logValues()
#endif
    }

    func body(content: Content) -> some View {
        content
            .modifier(AccessibilityLabelsModifier(labels: labels, isOpen: isOpen))
            .modifier(AccessibilityHintsModifier(hints: hints, isOpen: isOpen))
    }

#if DEBUG
    /// Just to let developers have in their console some warnings about missing accessibility values.
    /// Better to have this info in console instead of loosing time in testing.
    private func logValues() {
        if let labels = labels {
            if labels.opened.isEmpty {
                ODSLogger.warning("Accessibility opened label for Bottom Sheet is empty")
            }
            if labels.closed.isEmpty {
                ODSLogger.warning("Accessibility closed label for Bottom Sheet is empty")
            }
        }
        if let hints = hints {
            if hints.opened.isEmpty {
                ODSLogger.warning("Accessibility opened hints for Bottom Sheet is empty")
            }
            if hints.closed.isEmpty {
                ODSLogger.warning("Accessibility closed hints for Bottom Sheet is empty")
            }
        }
    }
#endif
    
    private struct AccessibilityLabelsModifier: ViewModifier {

        let labels: AccessibilityStatesValues?
        let isOpen: Binding<Bool>

        func body(content: Content) -> some View {
            if let labels = labels {
                content.accessibilityLabel(Text(isOpen.wrappedValue ? labels.opened : labels.closed))
            } else {
                content
            }
        }
    }

    private struct AccessibilityHintsModifier: ViewModifier {

        let hints: AccessibilityStatesValues?
        let isOpen: Binding<Bool>

        func body(content: Content) -> some View {
            if let hints = hints {
                content.accessibilityHint(Text(isOpen.wrappedValue ? hints.opened : hints.closed))
            } else {
                content
            }
        }
    }
}

// ========================
// MARK: - Preview Provider
// ========================

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
