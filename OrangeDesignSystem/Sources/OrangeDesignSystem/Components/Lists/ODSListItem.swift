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
public enum ODSListItemIcon {
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

/// Model describes the trailing icon of the list item.
/// A text or an "i" button are available.
public enum ODSListItemTrailingIconModel {
    case text(String)
    case infoButton(onClicked: () -> Void)
}

/// To sepecify the minimum height of the list item.
public enum ODSListItemMinHeight: CGFloat {
    case medium = 44.0
    case large = 60.0
}

/// This model can be used to achieve the list item templates existing in the spec.
///
public struct ODSListItemModel {

    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let leadingIcon: ODSListItemIcon?
    public let trailingIconModel: ODSListItemTrailingIconModel?
    public let minHeight: ODSListItemMinHeight

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingIconModel: The trailing meta text, info button
    ///     - minHeight: The minimum height of the list item (medium by default)
    ///
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: ODSListItemIcon? = nil,
        trailingIconModel: ODSListItemTrailingIconModel? = nil,
        minHeight: ODSListItemMinHeight = .medium)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingIconModel = trailingIconModel
        self.minHeight = minHeight

        id = UUID()
    }
}

///
/// This model can be used to achieve the list item templates existing in the spec.
///
public struct ODSListItemWithToggleModel {

    public let id: UUID
    public let title: String
    public let isOn: Binding<Bool>
    public let minHeight: ODSListItemMinHeight

    /// Create a model that describes the content of the `ODSListItemWithToggle`.
    ///
    /// - Parameters:
    ///    - title: The primary text of the list item
    ///    - isOn: A binding to a property that determines whether the toggle is ON or OFF.
    ///    - minHeight: The minimum height of the list item (medium by default)
    ///
    public init(title: String, isOn: Binding<Bool>, minHeight: ODSListItemMinHeight = .medium) {
        self.title = title
        self.minHeight = minHeight
        self.isOn = isOn

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

    let model: ODSListItemModel

    /// Create the `ODSListItem` view with content described by the `ODSListItemModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListItemModel) {
        self.model = model
    }

    public var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let leadingIcon = model.leadingIcon {
                ODSListItemLeadingIcon(model: leadingIcon)
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

            if let trailingIconModel = model.trailingIconModel {
                ODSListItemTrailingIcon(iconModel: trailingIconModel)
            }
        }
        .modifier(ODSListItemModifier(minHeight: model.minHeight))
    }
}

/// You can use this view to add item with toggle in list.
///
/// Do not use it in a NavigationLink because a chevron will be added next the the toggle
/// which it in not allowed by Orange design rules..
///
public struct ODSListItemWithToggle: View {

    let model: ODSListItemWithToggleModel

    /// Create the `ODSListItemWithToggle` view with content discribed by the `ODSListItemWithToggleModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListItemWithToggleModel) {
        self.model = model
    }

    public var body: some View {
        Toggle(isOn: model.isOn) {
            Text(LocalizedStringKey(model.title))
                .odsFont(.bodyRegular)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, ODSSpacing.m)
        .modifier(ODSListItemModifier(minHeight: model.minHeight))
    }
}
