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

                Text("Customize module")
                    .odsFont(.headline)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)

                Text("Some items such as : illustration (customizable), app name, privacy policy, terms of service and accessibility statement are mandatory.\nTo this standard screen you can add optional components :")

                ODSChipPicker(
                    title: "Application section",
                    selection: $model.applicationSectionOptions,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.ApplicationInformationOption.chips)
                .padding(.vertical, ODSSpacing.m)
                .padding(.horizontal, -ODSSpacing.m)
                
                ODSChipPicker(
                    title: "Optional About Items",
                    selection: $model.optionalAboutItems,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.OptionalAboutItem.chips)
                .padding(.vertical, ODSSpacing.s)
                .padding(.horizontal, -ODSSpacing.m)
                
                Stepper("Custom item(s) : \(model.numberOfCustomItems)",
                        value: $model.numberOfCustomItems,
                        in: 0 ... model.defaultCustomItems.count)
                    .padding(.vertical, ODSSpacing.s)
                
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

    @ObservedObject var model: AboutModuleModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ODSAboutModule(headerIllustration: headerIllustration,
                       applicationInformation: applicationInformation,
                       privacyPolicy: privacyPolicy,
                       acessibilityStatement: acessibilityStatement,
                       termsOfService: termsOfService,
                       listItemConfigurations: listItemConfigurations)
        .alert("Feedback Clicked", isPresented: $model.showFeedbackPopup) {
            Button("close", role: .cancel) {}
        }
    }

    // ==============================
    // MARK: Mandatory configurations
    // ==============================
    
    let headerIllustration = ThemeProvider().imageFromResources("AboutImage")
    let acessibilityStatement = ODSAboutAccessibilityStatement(reportPath: "path", reportDetail: URL(string: "https://www.apple.com")!)
    
    var privacyPolicy: ODSPrivacyPolicy {
        model.privacyPolicy
    }
    var applicationInformation: ODSAboutApplicationInformation {
        model.applicationInformation
        
    }
    
    @ViewBuilder
    private func termsOfService() -> some View {
        Text("Add terms of service here")
    }

    // ===========
    // MARK: Items
    // ===========

    private var appNewsItemConfiguration: ODSAboutAppNewsItemConfig? {
        if let appNewsPath = model.appNewsPath {
            return ODSAboutAppNewsItemConfig(path: appNewsPath)
        } else {
            return nil
        }
    }

    private var moreAppsItemConfiguration: ODSAboutMoreAppsItemConfig? {
        if let url = model.moreAppsUrl {
            return ODSAboutMoreAppsItemConfig(url: url)
        } else {
            return nil
        }
    }
    
    private var rateTheAppItemConfiguration: ODSAboutRateTheAppItemCondfig? {
        if let url = model.rateTheAppUrl {
            return ODSAboutRateTheAppItemCondfig(storeUrl: url)
        } else {
            return nil
        }
    }

    private var legalInformationItemConfiguration: ODSAboutLegalInformationItemConfig? {
        if let text = model.legalInformationText {
            return ODSAboutLegalInformationItemConfig {
                Text(text)
            }
        } else {
            return nil
        }
    }

    
    private var listItemConfigurations: [ODSAboutListItemConfig] {
        var configurations: [ODSAboutListItemConfig?] = [
            appNewsItemConfiguration,
            moreAppsItemConfiguration,
            rateTheAppItemConfiguration,
            legalInformationItemConfiguration
        ]
        
        configurations.append(contentsOf: model.customItems)
        return configurations.compactMap { $0 }
    }
}

#if DEBUG
struct ODSBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutSetup(model: AboutModuleModel())
    }
}
#endif
