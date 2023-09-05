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
import OrangeDesignSystem

struct AboutChangeLogItemConfig: ODSAboutListItemConfig {
    
    // =======================
    // MARK: Stored properties
    // =======================

    let title: String
    let icon: Image
    let priority: ODSAboutListItemPriority
    let target: ODSAboutListItemTarget

    // =================
    // MARK: Initializer
    // =================

    init(priority: ODSAboutListItemPriority) {
        title = "Change Log"
        icon = Image("ic_taskList", bundle: Bundle.ods)
        self.priority = priority
        target = .destination(AnyView(
            AboutHtmlAndMarkdownView(title: "Change Log", markdownFileName: "CHANGELOG", convertToHtml: true)))
    }
}


struct AboutDesignGuidelinesItemConfig: ODSAboutListItemConfig {
    
    // =======================
    // MARK: Stored properties
    // =======================

    let title: String
    let icon: Image
    let target: ODSAboutListItemTarget
    let priority: ODSAboutListItemPriority
    
    // =================
    // MARK: Initializer
    // =================

    init(priority: ODSAboutListItemPriority) {
        title = "Design guidelines"
        icon = Image("ic_tools", bundle: Bundle.main)
        self.priority = priority
        target = .action( { UIApplication.shared.open(URL(string: "https://system.design.orange.com/0c1af118d/p/95b685-ios/")!) })
    }
}

struct AboutScreen: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    private var applicationInformation: ODSAboutApplicationInformation
    private let privacyPolicy: ODSPrivacyPolicy
    private let accessibilityStatement: ODSAboutAccessibilityStatement
    private let appNewPath: String
    private let customItems: [ODSAboutListItemConfig]
    private let storeUrl = URL(string: "http://oran.ge/dsapp")!
    
    // =================
    // MARK: Initializer
    // =================

    init() {
        applicationInformation = ODSAboutApplicationInformation(
            name: "Orange Design System Demo",
            version: ODSApplicationVersion(marketingVersion: Bundle.main.marketingVersion, buildNumber: Bundle.main.buildNumber ?? "", buildType: Bundle.main.buildType),
            description: "In this app you'll find implemented code examples of the guidelines, components and modules, for the themes of the Orange Design System.",
            shareConfiguration: ODSAboutShareTheApplication(
                storeUrl: storeUrl,
                subject: "The Orange Design System",
                description: "You will find the Orange Design System Mobile App that provides examples of design implementations at: \(storeUrl.absoluteString)"),
            onFeedbackClicked: {
                UIApplication.shared.open(URL(string: "https://github.com/Orange-OpenSource/ods-ios/issues/new/choose")!)
            })
        
        privacyPolicy = ODSPrivacyPolicy.webview(.url(Bundle.main.url(forResource: "PrivacyNotice", withExtension: "html")!))
        
        accessibilityStatement = ODSAboutAccessibilityStatement(reportPath: "not_available_yet", reportDetail: URL(string: "not_available_yet")!)
        
        appNewPath = Bundle.main.path(forResource: "AppNews", ofType: "json")!
        
        let guideLinesPriority = 202
        let appNewsPriority = 201
        let changeLogPriority = 200
        customItems = [
            AboutDesignGuidelinesItemConfig(priority: guideLinesPriority) as ODSAboutListItemConfig,
            ODSAboutAppNewsItemConfig(path: appNewPath, priority: appNewsPriority),
            AboutChangeLogItemConfig(priority: changeLogPriority) as ODSAboutListItemConfig,
        ]
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
                           termsOfService: termOfService,
                           listItemConfigurations: customItems)
        }
        .navigationbarMenuForThemeSelection()
        .navigationViewStyle(.stack)
    }
    
    // ====================
    // MARK: Private helper
    // ====================

    @ViewBuilder
    private func termOfService() -> some View {
        AboutHtmlAndMarkdownView(title: "Term of Serice", htmlFileName: "CGU")
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

