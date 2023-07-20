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

/// Priority of item in the list
/// The hightest means that the item is placed at the top of the list.
/// The lowest means that the item is placed at the end (bottom) of the list.
///
/// @Remarks: pricacyPolicy, termsOfService and accessibility statement must be grouped, so their priority are fixed.
/// However, it is possible to add items before or after these elements using higher or lower priority.
/// Priorities are also define for app news, legal information, more apps and rate the app items, but it is possible to use another priority in the associated item initializer.
///
public typealias ODSAboutListItemPriority = Int

/// Default pritorities to order items in list
extension ODSAboutListItemPriority {
    public static let hightest = Int.max
    public static let lowest = Int.min

    /// Fixed positions of mandatory items
    public static let privacyPolicy = 102
    public static let termOfService = 101
    public static let accessibilityStatement = 100

    /// Positions of proposed items
    public static let appNews = 60
    public static let legalInformation = 50
    public static let moreApps = 40
    public static let rateTheApp = 30
}

/// Define the target of the list item.
/// - destination: means the items is a navigation link that opens the provided view.
/// - action: means the item is like a button that runs action when it is tapped.
///
public enum ODSAboutListItemTarget {
    case destination(AnyView)
    case action(() -> Void)
}

/// Use this protocol to define a custom list item with a dedicated configuration.
/// Have a look on __ODSAboutAppNewsItemConfig__ to see an example of implmentation.
/// 
public protocol ODSAboutListItemConfig {

    var title: String { get }
    var icon: Image { get }
    var target: ODSAboutListItemTarget  { get }
    var priority: ODSAboutListItemPriority { get }

}
