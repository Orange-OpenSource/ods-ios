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
import OrangeDesignSystem
import Foundation


class AboutModuleModel: ObservableObject {

    init() {
        self.showFeedbackPopup = false
    }
    
    // MARK: - Application infomration section
    
    enum ApplicationInformationOption: Int, CaseIterable {
        case version = 0
        case description
        case share
        case feedback
        
        var description: String {
            switch self {
            case .version:
                return "Version"
            case .description:
                return "Description"
            case .share:
                return "Share"
            case .feedback:
                return "Freedback"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
    
    @Published var showFeedbackPopup: Bool
    
    @Published var applicationSectionOptions: [ApplicationInformationOption] = ApplicationInformationOption.allCases
    
    var applicationInformation: ODSAboutApplicationInformation {
        let version = ODSApplicationVersion(marketingVersion: "0.14.0", buildNumber: "123456", buildType: "DEBUG")
        let description = "Add here a short description of the application. Over 2 lines use « more »."
        let shareConfiguration = ODSAboutShareTheApplication(
            storeUrl: URL(string: "https://www.apple.com")!,
            subject: "Add the subject of the sharing",
            description: "Add the description of the sharing")
        
        return ODSAboutApplicationInformation(name: "Orange Design System",
                                              version: applicationSectionOptions.contains(.version) ? version : nil,
                                              description: applicationSectionOptions.contains(.description) ? description : nil,
                                              shareConfiguration: applicationSectionOptions.contains(.share) ? shareConfiguration : nil,
                                              onFeedbackClicked: applicationSectionOptions.contains(.feedback) ? self.onFeedbackClicked : nil)
    }
    
    func onFeedbackClicked() {
        showFeedbackPopup = true
    }
    

    // MARK: - Optional About items
    enum OptionalAboutItem: Int, CaseIterable {
        case appNews = 0
        case moreApps
        case legalInformation
        case rateTheApp
        
        var description: String {
            switch self {
            case .appNews:
                return "App News"
            case .moreApps:
                return "More Orange Apps"
            case .legalInformation:
                return "Legal Information"
            case .rateTheApp:
                return "Rate The App"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }

    @Published var optionalAboutItems: [OptionalAboutItem] = OptionalAboutItem.allCases
    
    // MARK: - Proposed items in about module
    var appNewsPath: String? {
        optionalAboutItems.contains(.appNews) ?
        Bundle.main.path(forResource: "AppNews", ofType: "json") : nil
    }
    var moreAppsUrl: URL? {
        optionalAboutItems.contains(.moreApps) ?
        URL(string: "https://www.apple.com") : nil
    }
    var rateTheAppUrl: URL? {
        optionalAboutItems.contains(.rateTheApp) ?
        URL(string: "https://www.apple.com") : nil
    }
    var legalInformationText: String? {
        optionalAboutItems.contains(.legalInformation) ?
        "Add Legal information here" : nil
    }

    
    // MARK: - Additional custom links (list items)
    let defaultCustomItems: [ODSAboutListItemConfig] = [
        AboutMyRecipeItemConfiguration(),
        AboutMyReviewsItemConfiguration()
    ]
    @Published var numberOfCustomItems: Int = 2
    
    var customItems: [ODSAboutListItemConfig] {
        defaultCustomItems.prefix(numberOfCustomItems).compactMap { $0 as ODSAboutListItemConfig }
    }
    
    // MARK: - Privacy policy
    private static let privacyPolicyRawHtml: String =
"""
<html>
    <head>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
            <style>
                html {
                    margin: 16px;
                    -webkit-text-size-adjust: none;
                    font-family: -apple-system, sans-serif;
                }
                
                :root {
                    color-scheme: light dark;
                }
                
                body {
                    font: -apple-system-body;
                    background-color: clear;
                }
                
                h1 {
                    font: -apple-system-short-headline;
                    margin-top: 1em ;
                    margin-bottom: 0.3em;
                }
                
                h2 {
                    font: -apple-system-short-subheadline;
                    margin-top: 1em;
                    margin-bottom: 0.3em;
                }
                
                p {
                    font: -apple-system-body;
                }
                
                a:link, a:visited {
                    color: #FF7900;
                    text-decoration: none;
                }
                
                a:hover, a:active, a:focus {
                    color: #527EDB;
                }
            </style>
    </head>
    <body><p dir="auto">
        <h1>"<strong>Orange Design System</strong>" App Privacy Notice</h1>
        <p>This Privacy Notice aims to give the User information on how Orange Innovation, acting as Data Controller, processes his/her personal data when he/she uses its application "<strong>Orange Design System</strong>".</p>
        <p>This Notice may be supplemented by specific information relating to "<strong>Orange Design System</strong>" which is described in the relevant Terms and Conditions.</p>
        
        <h3>What is "Orange Design System"?</h3>
        <p>This mobile application is demonstrating the Orange Design System (ODS) with examples of code implementation following the Orange design guidelines provided at <a href="https://system.design.orange.com/">https://system.design.orange.com/</a>. The user will be able to select and view validated design implementations in the context of this mobile app.</p>
        
        <h3>Does Orange Innovation process personal data and under what legal basis?</h3>
        <p>Orange Innovation does not processe any User's personal data within the Orange Design System app.</p>
        
        <h3>Which personal data is needed in the context of this service?</h3>
        <p>Orange Innovation does not collects any personal data as part of this service</p>
        
        <h3>Data Protection Officer contact details</h3>
        <p>The User can contact the Orange Innovation Data Protection Officer for any question related to personal data protection:</p>
        
        <ul>
            <li>By e-mail :<a href="mailto:group-dpo.donnees-personnelles@orange.com">group-dpo.donnees-personnelles@orange.com</a></li>
            <li>By postal service :</li>
        </ul>
        
        <p>Orange SA</br>
        To the Data Protection Officer</br>
        111 quai du Président Roosevelt</br>
        92130 Issy-les-Moulineaux</p>
        
        <h3>Amendments to this Privacy Notice</h3>
        <p>This Privacy Notice may be subject to amendments.</p>
        <p>Last update: 20/03/2023.</p>
        </p>
    </body>
</html>
"""
    
    private static let privacyPolicyResourceUrl = Bundle.main.url(forResource: "ODSPrivacyNotice", withExtension: "html")!
    
    var privacyPolicy: ODSPrivacyPolicy {
        // ODSPrivacyPolicy.webview(.html(Self.privacyPolicyRawHtml))
        ODSPrivacyPolicy.webview(.url(Self.privacyPolicyResourceUrl))
    }
    
}
