////
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
/// Use the modifier to apply the right frame size and paddings.
///
/// The modifier can be used direcrtly on the __ODSListItem__ if it used without
/// navigation.
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
