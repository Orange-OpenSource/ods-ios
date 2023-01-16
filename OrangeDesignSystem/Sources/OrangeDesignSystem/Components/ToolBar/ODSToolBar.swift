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

///
/// <a href="https://system.design.orange.com/0c1af118d/p/06c413-bars-tool/b/951e5c" target="_blank">ODS Bars: Tool</a>.
///
/// A toolbar allows users to do specific actions regarding the entire page. It is placed at the bottom of the screen.
///
/// The following example shows how to build a `odsToolBar` with 2 labeled items:
///
///     struct YourView: View {
///         let description1 = ODSToolbarLabelDesription(text: "Action 1") { /* do something here */ }
///         let description2 = ODSToolbarLabelDesription(text: "Action 2") { /* do something here */ }
///         let labelItems = ODSToolbarLabeledItems(description1: description1, description2: description2)
///
///         var body: some View {
///            NavigationView {
///                ContentView()
///                .navigationBarTitle("", displayMode: .inline)
///                .navigationBarHidden(true)
///                .odsToolBar(items: labelItems)
///             }
///         }
///     }
///

extension View {
    /// Sets labeled items (2 up to 3) in tool bar.
    ///
    /// - Parameter items: The configuration containing items description.
    ///
    /// - Returns: A tool bar with labeled items placed as decribed in deseign.
    ///
    public func odsToolBar(items: ODSToolbarLabeledItems) -> some View {
        self.toolbar {
            ODSToolbarLabelContent(items: items)
        }
    }

    /// Sets icon items (2 up to 5) in tool bar.
    ///
    /// - Parameter items: The configuration containing items description.
    ///
    /// - Returns: A tool bar with icon items placed as decribed in deseign.
    ///
    public func odsToolBar(items: ODSToolbarIconsItems) -> some View {
        self.toolbar {
            ODSToolbarIconContent(items: items)
        }
    }
}

public struct ODSToolbarLabelDesription {

    // =======================
    // MARK: Stored Properties
    // =======================

    let text: String
    let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}

public struct ODSToolbarLabeledItems {

    // =======================
    // MARK: Stored Properties
    // =======================

    let description1: ODSToolbarLabelDesription
    let description2: ODSToolbarLabelDesription
    let description3: ODSToolbarLabelDesription?

    // ==================
    // MARK: Initializers
    // ==================

    public init(description1: ODSToolbarLabelDesription,
                description2: ODSToolbarLabelDesription,
                description3: ODSToolbarLabelDesription? = nil) {
        self.description1 = description1
        self.description2 = description2
        self.description3 = description3
    }
}

public struct ODSToolbarIconDesription {

    // =======================
    // MARK: Stored Properties
    // =======================

    let systemName: String
    let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }
}

public struct ODSToolbarIconsItems {

    // =======================
    // MARK: Stored Properties
    // =======================

    let description1: ODSToolbarIconDesription
    let description2: ODSToolbarIconDesription
    let description3: ODSToolbarIconDesription?
    let description4: ODSToolbarIconDesription?
    let description5: ODSToolbarIconDesription?

    // ==================
    // MARK: Initializers
    // ==================

    public init(description1: ODSToolbarIconDesription,
                description2: ODSToolbarIconDesription,
                description3: ODSToolbarIconDesription? = nil,
                description4: ODSToolbarIconDesription? = nil,
                description5: ODSToolbarIconDesription? = nil) {
        self.description1 = description1
        self.description2 = description2
        self.description3 = description3
        self.description4 = description4
        self.description5 = description5
    }
}
