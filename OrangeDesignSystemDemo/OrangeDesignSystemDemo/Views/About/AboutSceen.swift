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
import OrangeDesignSystem

struct AboutScreen: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let privacyPolicy = ODSPrivacyPolicy.webview(ODSWebContentSource.url(Bundle.main.url(forResource: "ODSPrivacyNotice", withExtension: "html")!))
    
    let accessibilityStatement = ODSAboutAccessibilityStatement(
        reportPath: "not_available_yet", reportDetail: URL(string: "not_available_yet")!)

    let appNewPath = Bundle.main.path(forResource: "AppNews", ofType: "json")

    let changeLogItem = ODSAboutListItem(title: "Change Log", icon: Image("ic_taskList", bundle: Bundle.ods)) {
        AboutHtmlAndMarkdownView(title: "Change Log",
                                 markdownFileName: "CHANGELOG",
                                 convertToHtml: true)
    }
    let designGuideLineItem = ODSAboutListItem(title: "Design guidelines", icon: Image("ic_tools")) {
        UIApplication.shared.open(URL(string: "https://system.design.orange.com/0c1af118d/p/95b685-ios/")!)
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ODSAboutModule(headerIllustration: ThemeProvider().imageFromResources("AboutImage"),
                           applicationInformation: applicationInformation,
                           privacyPolicy: privacyPolicy,
                           acessibilityStatement: accessibilityStatement,
                           applicationNewsPath: appNewPath,
                           moreAppsUrl: nil,
                           storeUrl: nil,
                           termsOfService: termOfService,
                           customItems: [designGuideLineItem, changeLogItem])
        }
        .navigationbarMenuForThemeSelection()
        .navigationViewStyle(.stack)
    }
    
    // =====================
    // MARK: Private Helpers
    // =====================

    private let storeUrl = URL(string: "https://itunes.apple.com/fr/app/id6446178285")!
    
    private var applicationInformation: ODSAboutApplicationInformation {
        ODSAboutApplicationInformation(
            name: "Orange Design System Demo",
            version: ODSApplicationVersion(marketingVersion: Bundle.main.marketingVersion, buildNumber: Bundle.main.buildNumber ?? "", buildType: Bundle.main.buildType),
            description: "In this app you'll find implemented code examples of the guidelines, components and modules, for the themes of the Orange Design System.",
            shareConfiguration: ODSAboutShareTheApplication(
                url: storeUrl,
                subject: "The Orange Design System",
                description: "You will find the Orange Design System Mobile iOS App that provides examples of design implementations in the app store at: \(storeUrl.absoluteString)"),
            onFeedbackClicked: {
                UIApplication.shared.open(URL(string: "https://github.com/Orange-OpenSource/ods-ios/issues/new/choose")!)
            })
    }
    
    @ViewBuilder
    private func termOfService() -> some View {
        AboutHtmlAndMarkdownView(title: "Term of Serice", htmlFileName: "ODSCGU")
    }
}


#if DEBUG
struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AboutScreen().preferredColorScheme($0)
        }
    }
}
#endif

