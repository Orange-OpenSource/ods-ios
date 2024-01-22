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

///
/// Use the modifier to apply the right frame size and paddings.
///
/// The modifier can be used directly on the __ODSListItem__ if it used without navigation.
/// If the __ODSListItem__ is used in a NavigationLink, don't forget to apply the modifier on it.
///
/// - In a __NavigationLink__:
///
///     NavigationLink { Text("Destination View")
///         ODSListItem(title: Text("Title"), subtitle: Text("Subtitle 2"), leading: .icon(Image(systemName: "heart")))
///     } label: {
///
///     }
///     .modifier(ODSListItemModifier(showSeparator: true))
///
/// - Outside a __NavigationLink__:
///
///     ODSListItem(title: Text("Title"), subtitle: Text("Subtitle 2"), leading: .icon(Image(systemName: "heart")))
///         .modifier(ODSListItemModifier(showSeparator: true))
///
public struct ODSListItemModifier: ViewModifier {

    // =======================
    // MARK: Stored Properties
    // =======================

    public static let defaultHeight: CGFloat = 44.0
    private let height: CGFloat
    private let showSeparator: Bool

    // =================
    // MARK: Initializer
    // =================

    public init(showSeparator: Bool = true, height: CGFloat = ODSListItemModifier.defaultHeight) {
        self.height = height
        self.showSeparator = showSeparator
    }

    // ==========
    // MARK: Body
    // ==========

    public func body(content: Content) -> some View {
        VStack(spacing: ODSSpacing.none) {
            content.padding(.horizontal, ODSSpacing.m)

            if showSeparator {
                Divider()
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(Visibility.hidden)
    }
}

extension View {

    /// Use the modifier to apply the right frame size and paddings on the __OSDListItem__.
    /// See __ ODSListItemModifier__ for more details.
    ///
    public func odsListItemStyle(showSeparator: Bool = true, height: CGFloat = ODSListItemModifier.defaultHeight) -> some View {
        modifier(ODSListItemModifier(showSeparator: showSeparator, height: height))
    }
}
