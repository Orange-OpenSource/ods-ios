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

public final class ODSDemoAboutConfig: NSObject {

    public static let instance = ODSDemoAboutConfig()

    let applicationInformation: ApplicationInformation

    override private init() {
        applicationInformation = ApplicationInformation(
            name: "Orange Design System Demo",
            version: Bundle.main.marketingVersion,
            buildNumber: Bundle.main.buildNumber,
            buildType: Bundle.main.buildType,
            description: "In this app you'll find implemented code examples of the guidelines, components and modules, for the themes of the Orange Design System.",
            imageHeader: Image("AboutImage", bundle: Bundle.main))
    }

    public func configure() {
        let appMenu = [
            ODSAboutItem(text: "Design guidelines", nextView: AnyView(EmptyView()), url:  "https://system.design.orange.com/0c1af118d/p/95b685-ios/"),
            ODSAboutItem(text: "Privacy policy", nextView: AnyView(ShowMarkdownView(title: "Privacy policy", fileName: "ODSDemoPrivacyNotice", convertToHtml: true))),
            ODSAboutItem(text: "Terms of service", nextView: AnyView(ShowMarkdownView(title: "Terms of service", fileName: "ODSDemoCGU"))),
            ODSAboutItem(text: "Change log",
                         nextView: AnyView(ShowMarkdownView(title: "Change log", fileName: "CHANGELOG", convertToHtml: true))),
            ODSAboutItem(text: "Report an issue", nextView: AnyView(EmptyView()), url: "https://github.com/Orange-OpenSource/ods-ios/issues/new/choose")   
        ]

        applicationInformation.menuList = appMenu
    }
}
