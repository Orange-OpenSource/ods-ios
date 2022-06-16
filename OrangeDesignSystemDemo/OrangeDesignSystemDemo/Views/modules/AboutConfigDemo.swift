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

import OrangeDesignSystem
import SwiftUI

public final class AboutConfigDemo: NSObject {

    public static let instance = AboutConfigDemo()

    let applicationDescription = ApplicationDescription(applicationName: "My application", applicationVersion: "1.0", applicationBuildNumber: nil)

    override private init() {}

    public func configure() {
        let appMenu = [
            ODSAboutItem(text: "What's new", nextView: AnyView(Text("What's new application..."))),
            ODSAboutItem(text: "External Web Browser", nextView: AnyView(EmptyView()), url: "https://system.design.orange.com/0c1af118d/p/95b685-ios/b/8626ca"),
            ODSAboutItem(text: "Web View", nextView: AnyView(Text("Error View")), safari: "https://system.design.orange.com/"),
        ]

        applicationDescription.menuList = appMenu
    }
}
