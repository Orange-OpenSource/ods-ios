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

// ============================
// MARK: List items description
// ============================

/// A list is a continuous vertical group of data entries like text, icons or images.
///
/// <a href="https://system.design.orange.com/0c1af118d/p/63daa5-lists/b/47ebec" target="_blank">ODS Lists</a>.
///
/// Two types of list item can be considered:
///
/// - standard: composed of leading icons, title, subtitle and trailing actions.
/// This item allows to enumerate data and offers actions (get information, display details or navigate to a new
/// page.
///
/// The following example shows how to build a List with standard elements:
///
///     struct YourView: View {
///         var body: some View {
///             NavigationView {
///                 List {
///                     NavigationLink {
///                         Text("Your details here")
///                     } label: {
///                         ODSListItem(
///                             title: Text("Item with details"),
///                             subtitle: Text("Subtitle 1"),
///                             leading: .icon(iconImage),
///                             trailingText: Text("Details")
///                         )
///                     }
///                     .odsListItemStyle()
///
///                     ODSListItem(
///                         title: Text("Item without details"),
///                         subtitle: Text("Subtitle 1"),
///                         leading: .icon(iconImage),
///                         trailingText: Text("Details")
///                     )
///                     .odsListItemStyle()
///                 }
///             }
///         }
///     }
///
/// - selection: composed of leading icons, title, subtitle and trailing indicator or switch to select the element.
/// Click on the list item with select or unselect the item.
///
/// The following example shows how to build a List with selection elements:
///
///     struct YourView: View {
///         @State private var optionA: Bool
///         @State private var optionB: Bool
///
///         var body: some View {
///             NavigationView {
///                 List {
///                    ODSListItem(
///                         title: Text("Option A"),
///                         subtitle: Text("Option A description"),
///                         trailingCheckmarkIsSelected: optionA
///                    )
///                    .odsListItemStyle()
///                    .onTapGesture {
///                         optionA.toggle()
///                    }
///
///                    ODSListItem(
///                         title: Text("Option B"),
///                         subtitle: Text("Option B description"),
///                         trailingCheckmarkIsSelected: optionB)
///                    )
///                    .odsListItemStyle()
///                    .onTapGesture {
///                         optionB.toggle()
///                    }
///                 }
///             }
///         }
///     }
///
/// REMARK: Don't forget to apply the style __.odsListItemStyle__ to get right frame height and paddings.
///
public struct ODSListItem: View {

    /// Describes the leading icon of the list item.
    ///
    /// Images can be loaded from resources or asynchronously from the specified URL.
    /// Until the image loads, the placeholder image is displayed.
    /// Image and placeholder are shaped (circular, wide or square)
    ///
    /// Icons are loaded from resources and no shape is applyed.
    public enum Leading {
        /// A Solaris icon from image resource.
        case icon(Image)

        /// An image cropped into a circle.
        /// - Parameter source: The source of the image
        case circularImage(source: ODSImage.Source)

        /// An image cropped into a square.
        /// - Parameter source: The source of the image
        case squareImage(source: ODSImage.Source)

        /// An image cropped into a rectangle.
        /// - Parameter source: The source of the image
        case wideImage(source: ODSImage.Source)
    }

    /// Describes the trailing element of the list item.
    /// This type of element can be an information, a selection or an action
    enum TrailingElement {
        /// A single text should be short ideally one word.
        case textOnly(Text)

        /// An i button with its action and a single text (should be short ideally one word)
        case iButton(() -> Void, Text?)

        /// A toggle with its binding that determines whether it is on or off.
        case toggle(Binding<Bool>)

        /// A checkmark with a flag to indicate if chekmark is selected (visible) or not.
        case checkmark(Bool)
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text
    private let subtitle: Text?
    private let leading: Leading?
    private let trailing: TrailingElement?
    private let height = ODSListItemModifier.defaultHeight

    // =================
    // MARK: Initializer
    // =================

    /// Describe the Item content without trailing element.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leading: Leading? = nil
    ) {
        self.init(title: title, subtitle: subtitle, leading: leading, trailing: nil)
    }

    /// Describe the Item content with trailing text.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///     - trailingText The text on trailing
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leading: Leading? = nil,
        trailingText: Text
    ) {
        self.init(title: title, subtitle: subtitle, leading: leading, trailing: .textOnly(trailingText))
    }

    /// Describe the Item content with trailing text and iButton.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///     - trailingText The text on trailing
    ///     - trailingIButtonAction: The action the i button on trailing
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leading: Leading? = nil,
        trailingText: Text? = nil,
        trailingIButtonAction: @escaping () -> Void
    ) {
        self.init(title: title, subtitle: subtitle, leading: leading, trailing: .iButton(trailingIButtonAction, trailingText))
    }

    /// Describe the Item content with trailing toggle.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///     - trailingText The text on trailing
    ///     - trailingToggleIsOn: The binding to a property that determines whether the toggle is on or off.
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leading: Leading? = nil,
        trailingToggleIsOn: Binding<Bool>
    ) {
        self.init(title: title, subtitle: subtitle, leading: leading, trailing:
                .toggle(trailingToggleIsOn))
    }

    /// Describe the Item content with trailing checkmark.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///     - trailingText The text on trailing
    ///     - trailingCheckmarkIsSelected: The flag to indicate if checkmark is visbile or not.
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leading: Leading? = nil,
        trailingCheckmarkIsSelected: Bool
    ) {
        self.init(title: title, subtitle: subtitle, leading: leading, trailing: .checkmark(trailingCheckmarkIsSelected))
    }

    /// Describe the Item content with trailing element.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtitle: The secondary text of the list item (optional)
    ///     - leading: The leading icon of the list item (optional)
    ///     - trailing: The trailing element
    ///
    init(
       title: Text,
       subtitle: Text? = nil,
       leading: Leading? = nil,
       trailing: TrailingElement? = nil
   ) {
       self.title = title
       self.subtitle = subtitle
       self.leading = leading
       self.trailing = trailing
   }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let leading = self.leading {
                LeadingView(element: leading, height: height)
                    .padding(.vertical, ODSSpacing.s)
            }

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                title
                    .odsFont(.bodyRegular)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                subtitle?
                    .odsFont(.footnote)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, ODSSpacing.s)

            if let trailing = trailing {
                TrailingView(element: trailing, height: height)
            }
        }
        .frame(minHeight: height)
        .contentShape(Rectangle())
    }
}
