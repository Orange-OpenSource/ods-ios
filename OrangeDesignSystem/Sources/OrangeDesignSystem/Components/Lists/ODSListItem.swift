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

/// Describes the leading icon of the list item __ODSListItem__.
/// Image can be loaded from resources or asynchronously from the specified URL.
/// Until the image loads, the placeholder image is displayed.
public enum ODSListItemLeadingIcon {
    case icon(Image)                    // A standard icon.
    case circularImage(source: Source)  // An image cropped into a circle.
    case squareImage(source: Source)    // An image cropped into a square.
    case wideImage(source: Source)      // An image cropped into a rectangle.

    public enum Source {
        case image(Image)
        case asyncImage(URL, Image)
    }
}

// =============
// MARK: Models
// =============

/// Describes the trailing icon of the list item
/// for additional actions.
/// A text or an "i" button are available.
public struct ODSListItemTrailingActions {

    public typealias OnIButtionClicked = () -> Void
    let displayText: String?
    let onIButtionClicked: OnIButtionClicked?
    let id: UUID

    /// Use to display a text
    ///
    /// - Parameter displayText: Text to dsiplay
    ///
    public init(displayText: String) {
        self.displayText = displayText
        self.onIButtionClicked = nil
        self.id = UUID()
    }

    /// Use to display "i" button providing callback to handle action
    ///
    /// - Parameter onIButtionClicked: callback to be invoked when "i" button is being clicked.
    ///
    public init(onIButtionClicked: @escaping OnIButtionClicked) {
        self.displayText = nil
        self.onIButtionClicked = onIButtionClicked
        self.id = UUID()
    }

    /// Use to display a text and display "i" button
    ///
    /// - Parameters:
    ///     - displayText: Text to dsiplay
    ///     - onIButtionClicked: callback to be invoked when "i" button is being clicked.
    ///
    public init(displayText: String, onIButtionClicked: @escaping OnIButtionClicked) {
        self.displayText = displayText
        self.onIButtionClicked = onIButtionClicked
        self.id = UUID()
    }
}

/// Describes the trailing icon of the list item.
public enum ODSListItemTrailingSelection: Int, CaseIterable {
    case toggle
    case checkmark
}

/// This model can be used to achieve the list item templates existing in the spec.
///
public class ODSListItemModel: ObservableObject {

    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let leadingIcon: ODSListItemLeadingIcon?
    public let trailingActions: ODSListItemTrailingActions?
    public let trailingSelection: ODSListItemTrailingSelection?
    @Published var isSelected: Bool

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingActions = nil
        self.trailingSelection = nil
        self.isSelected = false
        
        id = UUID()
    }
    
    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingActions: The trailing meta text or info button actions
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        trailingActions: ODSListItemTrailingActions)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingActions = trailingActions
        self.trailingSelection = nil
        self.isSelected = false
        
        id = UUID()
    }

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingSelection: The trailing selection item
    ///     - minHeight: The minimum height of the list item (medium by default)
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        trailingSelection: ODSListItemTrailingSelection,
        isSelected: Bool = false)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingActions = nil
        self.trailingSelection = trailingSelection
        self.isSelected = isSelected

        id = UUID()
    }
}

// ============
// MARK: Views
// ============
/// A list is a continuous vertical group of data entries like text, icons or images.
///
/// <a href="https://system.design.orange.com/0c1af118d/p/63daa5-lists/b/47ebec" target="_blank">ODS Lists</a>.
///
/// You can use this view in the NavigationLink providing the right model:
///
///     NavigationLink(ODSListItemModel(title: "Title", subtitle: "Subtitle")) {
///         Text("The destination View")
///     }
///
public struct ODSListItem: View {

    @ObservedObject var model: ODSListItemModel

    /// Create the `ODSListItem` view with content described by the `ODSListItemModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListItemModel) {
        self.model = model
    }

    func content() -> some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let leadingIcon = model.leadingIcon {
                LeadingIcon(model: leadingIcon)
                    .padding(.vertical, ODSSpacing.s)
            }

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                Text(LocalizedStringKey(model.title))
                    .odsFont(.bodyRegular)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                if let subtitle = model.subtitle {
                    Text(LocalizedStringKey(subtitle))
                        .odsFont(.footnote)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.vertical, ODSSpacing.s)

            Spacer()

            TrailingIcons(model: model)
        }
        .frame(minHeight: 44)
    }

    public var body: some View {
        if model.trailingSelection == .checkmark {
            content()
                .contentShape(Rectangle())
                .onTapGesture {
                    model.isSelected.toggle()
                }
        } else {
            content()
        }
    }
}
