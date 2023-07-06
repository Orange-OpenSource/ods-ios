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

    // MARK: - Application infomration
    
    func appInfo(onFeedbackClicked: @escaping () -> Void ) -> ODSAboutApplicationInformation {
        ODSAboutApplicationInformation(name: "Orange Design System",
                                       version: "0.14.0",
                                       buildNumber: "123456",
                                       buildType: "DEBUG",
                                       description: "Add here a short description of the application. Over 2 lines use « more ».",
                                       shareUrl: URL(string: "https://www.google.fr")!,
                                       onFeedbackClicked: onFeedbackClicked)
    }
    
    // MARK: - AppNews
    var applicationNewsPath: String? {
        Bundle.main.path(forResource: "AppNews", ofType: "json")
    }

    // MARK: - Additional custom links (list items)
    
    let defaultCustomItems = [
        ODSAboutCustomListItem(title: "My reviews", icon: Image("ic_subtitles"), destination: AnyView(Text("My reviews"))),
        ODSAboutCustomListItem(title: "My recipes", icon: Image("ic_folderFavourite"), destination: AnyView(Text("My recipes")))
    ]
    @Published var numberOfLinks: Int = 2
    var customItems: [ODSAboutCustomListItem] {
        Array(defaultCustomItems.prefix(numberOfLinks))
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
