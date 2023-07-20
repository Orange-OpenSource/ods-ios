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
/// Configuration to add in list the item that opens the AppNews page.
/// This page needs the path to the json file containing News.
///
/// By default, this item is palced after the item of accessibility statement. That can be changed with new priority set in the configuration.
///
public struct ODSAboutAppNewsItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority

    private let path: String

    // =================
    // MARK: Initializer
    // =================

    /// Initiliazes the configuration.
    ///
    /// - Parmaters:
    ///    - path: Path to the json file.
    ///    - priority: Priority to adjust the position of the item in the list.
    ///
    public init(path: String, priority: ODSAboutListItemPriority = .appNews) {
        self.path = path
        self.priority = priority
        self.title = "App News"
        self.icon = Image("ic_taskList", bundle: Bundle.ods)
        self.target = .destination(AnyView(AppNewsList(fromFile: path)))
    }
}
