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

import Foundation
import SwiftUI

public struct ODSAboutModule: View {

    // ==================
    // MARK: Initializers
    // ==================
    let headerIllustration: Image
    let applicationInformation: ODSAboutApplicationInformation
    let privacyPolicy: ODSPrivacyPolicy

    public init(headerIllustration: Image = Image("ic_about_image", bundle: Bundle.ods),
                applicationInformation: ODSAboutApplicationInformation,
                privacyPolicy: ODSPrivacyPolicy) {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation
        self.privacyPolicy = privacyPolicy
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {

                headerIllustration
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

                ApplicationInformationView(applicationInformation: applicationInformation)
                    .padding(.all, ODSSpacing.m)

                AboutPrivacyPolicyEntity(policy: privacyPolicy)

                NavigationLink(ODSListStandardItemModel(title: "Term of service")) {
                    Text("")
                }
                .padding(.horizontal, ODSSpacing.m)
            }
//            ODSAboutItemView()
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
        .background(ODSInternalColor.primaryBackground.color)
    }
}
