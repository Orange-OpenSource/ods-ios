/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
                Text("screens.modules.about.description")

                Text("screens.modules.about.customize")
                    .odsFont(.headline)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)

                Text("screens.modules.about.mandatory")

                ODSChipPicker(
                    title: "screens.modules.about.picker.app_section".🌐,
                    selection: $model.applicationSectionOptions,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.ApplicationInformationOption.chips)
                .padding(.vertical, ODSSpacing.m)
                .padding(.horizontal, -ODSSpacing.m)
                
                ODSChipPicker(
                    title: "screens.modules.about.picker.optional_about_items".🌐,
                    selection: $model.optionalAboutItems,
                    allowZeroSelection: true,
                    chips: AboutModuleModel.OptionalAboutItem.chips)
                .padding(.vertical, ODSSpacing.s)
                .padding(.horizontal, -ODSSpacing.m)
                
                Stepper("screens.modules.about.picker.custom_items" <-  "\(model.numberOfCustomItems)",
                        value: $model.numberOfCustomItems,
                        in: 0 ... model.defaultCustomItems.count)
                    .padding(.vertical, ODSSpacing.s)
                
                NavigationLink(isActive: $showDemo) {
                    AboutModuleDemo(model: model)
                } label: {
                    ODSButton(text: Text("screens.modules.about.buttons.view_demo"), emphasis: .high, fullWidth: true) {
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
        .alert("screens.modules.about.alert.feedback_clicked", isPresented: $model.showFeedbackPopup) {
            Button("screens.modules.about.buttons.close", role: .cancel) {}
        }
    }

    // ==============================
    // MARK: Mandatory configurations
    // ==============================
    
    let headerIllustration = ThemeProvider().imageFromResources("AboutImage")
    let acessibilityStatement = ODSAboutAccessibilityStatement(fileName: "AccessibilityStatement", reportDetail: URL(string: "https://la-va11ydette.orange.com/")!)
    
    var privacyPolicy: ODSPrivacyPolicy {
        model.privacyPolicy
    }
    var applicationInformation: ODSAboutApplicationInformation {
        model.applicationInformation
        
    }
    
    @ViewBuilder
    private func termsOfService() -> some View {
        Text("screens.modules.about.texts.add_cgu")
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
