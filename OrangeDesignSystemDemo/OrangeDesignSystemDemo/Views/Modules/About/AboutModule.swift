//
//  File.swift
//  
//
//  Created by Ludovic PINEL on 19/06/2023.
//

import SwiftUI
import OrangeDesignSystem


struct AboutModule: View {
    var body: some View {
        AboutSetup()
    }
}

let appInfo = ODSAboutApplicationInformation(name: "Orange Design System",
                                            version: "0.14.0",
                                            buildNumber: "123456",
                                            description: "Add here a short description of the application. Over 2 lines use « more ».",
                                             shareUrl: URL(string: "https://www.google.fr")!,
                                             feedbackUrl: URL(string: "https://www.google.fr")!)

let privacyPolicyRawHtml: String =
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

//let privacyPolicy = ODSPrivacyPolicy.webview(.html(privacyPolicyRawHtml))

let resourceUrl = Bundle.main.url(forResource: "ODSPrivacyNotice", withExtension: "html")!
let privacyPolicy = ODSPrivacyPolicy.webview(.url(resourceUrl))

struct AboutSetup: View {
    @State var showDemo: Bool = false
    @State var numberOfLinks: Int = 0

    var body: some View {
        ScrollView {
            ThemeProvider().imageFromResources("AboutImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading) {
                Text("An « About » screen should be displayed in all Orange applications to show the application name, software version as wall as all legal data protection, privacy, terms of service and accessibility statement.")
                        
                
                Text("Customise the module")
                    .odsFont(.headline)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)
                
                Text("Some items such as : illustration (customizable), app name, privacy policy, terms of service and accessibility statement are mandatory.\nTo this standard screen you can add optional components :")
                
                Stepper("Additional link(s): \(numberOfLinks)",
                        value: $numberOfLinks,
                        in: 0 ... 4)
                    .padding(.vertical, ODSSpacing.m)
                
                NavigationLink(isActive: $showDemo) {
                    ODSAboutModule(headerIllustration: ThemeProvider().imageFromResources("AboutImage"),
                                   applicationInformation: appInfo,
                                   privacyPolicy: privacyPolicy)
                } label: {
                    ODSButton(text: "View demo", emphasis: .highest, variableWidth: false) {
                        showDemo.toggle()
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }
}


#if DEBUG
struct ODSBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutSetup()
    }
}
#endif
