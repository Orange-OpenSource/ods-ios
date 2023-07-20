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
/// Configuration to add in list the item that opens the application page on the apple store.
///
/// By default, this item is palced after the item of More Apps. That can be changed by priority set in the configuration.
///
public struct ODSAboutRateTheAppItemCondfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority

    private let storeUrl: URL

    // =================
    // MARK: Initializer
    // =================

    /// Initiliazes the configuration.
    ///
    /// - Parmaters:
    ///    - storeUrl: URL of the application on the store.
    ///    - priority: Priority to adjust the position of the item in the list.
    ///
    public init(storeUrl: URL, priority: ODSAboutListItemPriority = .rateTheApp) {
        title = "Rate this app"
        icon = Image("ic_review", bundle: Bundle.ods)
        self.priority = priority
        self.storeUrl = storeUrl
        self.target = .action( { UIApplication.shared.open(storeUrl) } )
    }
}
