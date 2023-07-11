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

struct AboutModule: View {
    var body: some View {
        AboutSetup(model: AboutModuleModel())
    }
}

struct AboutSetup: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State var showDemo: Bool = false
    @ObservedObject var model: AboutModuleModel
    
    // =================
    // MARK: Initializer
    // =================

    init(model: AboutModuleModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

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
                
                ODSChipPicker(
                    title: "Options for application section",
                    selection: $model.applicationSectionOptions,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.ApplicationInformationOption.chips)
                .padding(.vertical, ODSSpacing.m)
                .padding(.horizontal, -ODSSpacing.m)
                
                ODSChipPicker(
                    title: "Proposed Links",
                    selection: $model.proposedLinkOptions,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.ProposedLinkOption.chips)
                .padding(.vertical, ODSSpacing.m)
                .padding(.horizontal, -ODSSpacing.m)
                
                Stepper("Additional link(s) : \(model.numberOfLinks)",
                        value: $model.numberOfLinks,
                        in: 0 ... model.defaultCustomItems.count)
                    .padding(.vertical, ODSSpacing.m)
                
                NavigationLink(isActive: $showDemo) {
                    AboutModuleDemo(model: model)
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


struct AboutModuleDemo: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let model: AboutModuleModel
    @State var showAlert = false

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        module
        .alert("Feedback Clicked", isPresented: $showAlert) {
            Button("close", role: .cancel) {}
        }
    }
    
    @ViewBuilder
    var module: some View {
        let headerIllustration = ThemeProvider().imageFromResources("AboutImage")
        let applicationInformation = model.appInfo { showAlert.toggle() }
        let applicationNewsPath = model.applicationNewsPath
        let privacyPolicy =  model.privacyPolicy
        let termeOfService = { Text("Term of service") }
        let customItems = model.customItems
        let acessibilityStatement = ODSAboutAccessibilityStatement(reportPath: "path", reportDetail: URL(string: "https://www.apple.com")!)
        let moreAppsUrl = model.proposedLinkOptions.contains(.moreApps) ? URL(string: "https://www.apple.com") : nil
        let storeUrl = model.proposedLinkOptions.contains(.rateTheApp) ? URL(string: "https://www.apple.com") : nil

        if model.proposedLinkOptions.contains(.legalInformation) {
            ODSAboutModule(headerIllustration: headerIllustration,
                           applicationInformation: applicationInformation,
                           privacyPolicy: privacyPolicy,
                           acessibilityStatement: acessibilityStatement,
                           applicationNewsPath: applicationNewsPath,
                           moreAppsUrl: moreAppsUrl,
                           storeUrl: storeUrl,
                           termsOfService: termeOfService,
                           legalInformation: { Text("Legal information goes here") },
                           customItems: customItems)
        } else {
            ODSAboutModule(headerIllustration: headerIllustration,
                           applicationInformation: applicationInformation,
                           privacyPolicy: privacyPolicy,
                           acessibilityStatement: acessibilityStatement,
                           applicationNewsPath: applicationNewsPath,
                           moreAppsUrl: moreAppsUrl,
                           storeUrl: storeUrl,
                           termsOfService: termeOfService,
                           customItems: customItems)
        }
    }
}

#if DEBUG
struct ODSBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutSetup(model: AboutModuleModel())
    }
}
#endif
