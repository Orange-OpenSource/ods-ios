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

// ================================
// MARK: Common list items elements
// ================================

/// Defines a the generic protocol to achieve the list item templates.
///
protocol ODSListItemModel {
    var id: UUID { get } // Unic identifier of item
    var title: String { get } // The mandatory title of the list item
    var subtitle: String? { get } // Optional subtitle of the list item
    var leadingIcon: ODSListItemLeadingIcon? { get } // Optional leading icon
}

/// Describes the leading icon of the list items.
///
/// Images can be loaded from resources or asynchronously from the specified URL.
/// Until the image loads, the placeholder image is displayed.
/// Image and placeholder are shaped (circular, wide or square)
///
/// Icons are loaded from ressources and no shape is applyed.
///
public enum ODSListItemLeadingIcon {
    case icon(Image)                    // A standard icon.
    case circularImage(source: ODSImage.Source)  // An image cropped into a circle.
    case squareImage(source: ODSImage.Source)    // An image cropped into a square.
    case wideImage(source: ODSImage.Source)      // An image cropped into a rectangle.
}

// ===============================
// MARK: Standard List items model
// ===============================

public class ODSListStandardItemModel: ODSListItemModel {

    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let leadingIcon: ODSListItemLeadingIcon?
    public let trailingActions: ODSListItemTrailingActions?

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingActions: The trailing actions (optional)
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        trailingActions: ODSListItemTrailingActions? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingActions = trailingActions

        id = UUID()
    }
}

/// Describes the trailing icon of the list item for additional actions.
/// A text or an "i" button are available.
public struct ODSListItemTrailingActions {

    public typealias OnIButtonClicked = () -> Void
    let displayText: String?
    let onIButtonClicked: OnIButtonClicked?
    let id: UUID

    /// Use to display a text
    ///
    /// - Parameter displayText: Text to dsiplay
    ///
    public init(displayText: String) {
        self.displayText = displayText
        self.onIButtonClicked = nil
        self.id = UUID()
    }

    /// Use to display "i" button providing callback to handle action
    ///
    /// - Parameter onIButtonClicked: callback to be invoked when "i" button is being clicked.
    ///
    public init(onIButtonClicked: @escaping OnIButtonClicked) {
        self.displayText = nil
        self.onIButtonClicked = onIButtonClicked
        self.id = UUID()
    }

    /// Use to display a text and display "i" button
    ///
    /// - Parameters:
    ///     - displayText: Text to dsiplay
    ///     - onIButtonClicked: callback to be invoked when "i" button is being clicked.
    ///
    public init(displayText: String, onIButtonClicked: @escaping OnIButtonClicked) {
        self.displayText = displayText
        self.onIButtonClicked = onIButtonClicked
        self.id = UUID()
    }
}

// ================================
// MARK: Selection List items model
// ================================

public class ODSListSelectionItemModel: ODSListItemModel, ObservableObject {

    /// Describes the trailing icon of the list item.
    public enum TrailingSelection: Int, CaseIterable {
        case toggle
        case checkmark
    }

    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let leadingIcon: ODSListItemLeadingIcon?
    public let trailingSelection: TrailingSelection
    @Published var isSelected: Bool

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingSelection: The trailing selection
    ///     - isSelected: State to know if item is selected
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        trailingSelection: TrailingSelection,
        isSelected: Bool = false)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingSelection = trailingSelection
        self.isSelected = isSelected

        id = UUID()
    }
}

