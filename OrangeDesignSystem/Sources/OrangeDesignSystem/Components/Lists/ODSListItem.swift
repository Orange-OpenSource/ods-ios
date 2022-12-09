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

/// A list is a continuous vertical group of data entries like text, icons or images.
///
/// <a href="https://system.design.orange.com/0c1af118d/p/63daa5-lists/b/47ebec" target="_blank">ODS Lists</a>.
///
/// You can use this view in the NavigationLink providing the right model:
///
///     NavigationLink(ODSListStandardItemModel(title: "Title", subtitle: "Subtitle")) {
///         Text("The destination View")
///     }
///
///
public struct ODSListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListItemModel

    // =================
    // MARK: Initializer
    // =================

    /// Create the `ODSListItem` view with content described by the `ODSListItemModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListItemModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        if let standardModel = model as? ODSListStandardItemModel {
            ODSStandardListItem(model: standardModel)
        } else {
            if let selectionModel = model as? ODSListSelectionItemModel {
                ODSSelectionListItem(model: selectionModel)
            }
        }
    }
}

extension NavigationLink where Label == ODSListItem {

    /// Creates a navigation link that presents a destination view, with a ODSListItem label.
    /// - Parameters:
    ///   - model: A model describing each element of the item.
    ///   - destination: A view for the navigation link to present.
    public init(_ model: ODSListStandardItemModel, @ViewBuilder destination: () -> Destination) {
        self.init(destination: destination) {
            ODSListItem(model: model)
        }
    }

    /// Creates a navigation link that presents the destination view when active.
    /// - Parameters:
    ///   - model: A model describing each element of the item.
    ///   - isActive: A binding to a Boolean value that indicates whether
    ///   `destination` is currently presented.
    ///   - destination: A view for the navigation link to present.
    public init(_ model: ODSListStandardItemModel, isActive: Binding<Bool>, @ViewBuilder destination: () -> Destination) {
        self.init(isActive: isActive, destination: destination) {
            ODSListItem(model: model)
        }
    }

    /// Creates a navigation link that presents the destination view when
    /// a bound selection variable equals a given tag value.
    /// - Parameters:
    ///   - model: A model describing each element of the item.
    ///   - tag: The value of `selection` that causes the link to present
    ///   `destination`.
    ///   - selection: A bound variable that causes the link to present
    ///   `destination` when `selection` becomes equal to `tag`.
    ///   - destination: A view for the navigation link to present.
    public init<V>(_ model: ODSListStandardItemModel, tag: V, selection: Binding<V?>, @ViewBuilder destination: () -> Destination) where V: Hashable {
        self.init(tag: tag, selection: selection, destination: destination) {
            ODSListItem(model: model)
        }
    }
}
