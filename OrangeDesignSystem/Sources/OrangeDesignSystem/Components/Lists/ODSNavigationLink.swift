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

extension NavigationLink where Label == ODSListStandardItem {

    /// Creates a navigation link that presents a destination view, with a __ODSListStandardItem__ label.
    /// - Parameters:
    ///   - model: A model describing each element of the item.
    ///   - destination: A view for the navigation link to present.
    public init(_ model: ODSListStandardItemModel, @ViewBuilder destination: () -> Destination) {
        self.init(destination: destination) {
            ODSListStandardItem(model: model)
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
            ODSListStandardItem(model: model)
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
            ODSListStandardItem(model: model)
        }
    }
}
