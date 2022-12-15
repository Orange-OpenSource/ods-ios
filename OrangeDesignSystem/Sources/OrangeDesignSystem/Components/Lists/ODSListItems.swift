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
/// Two types of list item can be considered :
///
/// - standard: composed of leading icons, title, subtile and trailing actions.
/// This item allows to enumerate data and offers actions (get information, display details or navigate to a new
/// page.
///
/// - selection: composed of leading icons, title, subtile and trailing indicator or switch to select the element.
/// Click on the list item with select or unselect the item.
///

// =========================
// MARK: Standard list items
// =========================

///
/// The standard list items can be used to enumerate data in list
/// and to navigate to new screen showing more details.
///
/// The following example shows how to build a List with standard elements:
///
///     struct YourView: View {
///         let modelWithDetails: ODSListStandardItemModel
///         let modelWithoutDetails: ODSListStandardItemModel
///
///         init() {
///             let iconImage = Image(systemName: "heart")
///             modelWithDetails = ODSListStandardItemModel(title: "Title 1",
///                                                         subtitle: "Subtitle 1",
///                                                         leadingIcon: .icon(iconImage),
///                                                         trailingActions: ODSListItemTrailingActions(displayText: "Details"))
///
///             modelWithoutDetails = ODSListStandardItemModel(title: "Title 2",
///                                                            subtitle: "Subtitle 2",
///                                                            leadingIcon: .icon(iconImage))
///         }
///
///         var body: some View {
///             NavigationView {
///                 List {
///                     NavigationLink(modelWithDetails) {
///                         Text("Your details here")
///                     }
///
///                     ODSStandardListItem(model: modelWithoutDetails)
///                 }
///             }
///         }
///     }
///
public struct ODSStandardListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListStandardItemModel

    // =================
    // MARK: Initializer
    // =================

    /// Create the `ODSStandardListItem` view with content described by the `ODSListStandardItemModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListStandardItemModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        ODSListItemContent(model: model)
    }
}

// ==========================
// MARK: Selection list items
// ==========================

///
/// The selection list items can be used to enumerate data as list in order to select elements.
///
/// Remarks: This list item should never be used in a __NavigationLink__.
///
/// The following example shows how to build a List with elements for selection:
///
///     struct YourView: View {
///         let models: [ODSListSelectionItemModel]
///
///         init() {
///             let iconImage = Image(systemName: "heart")
///             models = [
///                 ODSListSelectionItemModel(
///                     title: "Title 1",
///                     subtitle: "Subtitle 1",
///                     leadingIcon: .icon(iconImage),
///                     trailingSelection: .checkmark),
///                 ODSListSelectionItemModel(
///                     title: "Title 2",
///                     subtitle: "Subtitle 2",
///                     trailingSelection: .checkmark)
///             ]
///         }
///
///         var body: some View {
///             List {
///                 ForEach(models, id: \.id) { model in
///                     ODSSelectionListItem(model: model)
///                 }
///             }
///         }
///     }
///
public struct ODSSelectionListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ODSListSelectionItemModel

    /// Create the `ODSSelectionListItem` view with content described by the `ODSListSelectionItemModel`.
    ///
    /// - Parameter model: The model describing the item.
    ///
    public init(model: ODSListSelectionItemModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        if model.trailingSelection == .checkmark {
            ODSListItemContent(model: model)
                .contentShape(Rectangle())
                .onTapGesture {
                    model.isSelected.toggle()
                }
        } else {
            ODSListItemContent(model: model)
        }
    }
}
