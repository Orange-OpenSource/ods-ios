//
// MIT License
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
/// Configuration to add in list the item that opens the LegalInformation page.
/// This page can be a webview or native view.
///
/// By default, this item is palced after the item of App News. That can be changed with new priority set in the configuration.
///
///
public struct ODSAboutLegalInformationItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority

    // =================
    // MARK: Initializer
    // =================

    /// Initiliazes the configuration.
    ///
    /// - Parmaters:
    ///    - priority: Priority to adjust the position of the item in the list.
    ///    - legalInformation: A view builder to create a view that describes the `legalInformation`.
    ///
    public init<LegalInformation>(priority: ODSAboutListItemPriority = .legalInformation, @ViewBuilder legalInformation: () -> LegalInformation) where LegalInformation: View {
        title = "Legal information"
        icon = Image("ic_legal", bundle: Bundle.ods)
        self.priority = priority
        self.target = .destination(AnyView(legalInformation()))
    }
}
