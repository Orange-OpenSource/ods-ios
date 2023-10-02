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

struct AboutApplicationInformation: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let applicationInformation: ODSAboutApplicationInformation

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            Text(applicationInformation.name)
                .odsFont(.largeTitle)
                .fixedSize(horizontal: false, vertical: true)

            if applicationInformation.shareConfiguration != nil || applicationInformation.onFeedbackClicked != nil {
                HStack(spacing: ODSSpacing.none) {
                    if let shareConfiguration = applicationInformation.shareConfiguration {
                        ODSButton(text: "Share", image: Image("ic_share", bundle: Bundle.ods), emphasis: .lowest) {
                            ShareSheet.show(content: shareConfiguration.description, subject: shareConfiguration.subject, url: shareConfiguration.storeUrl)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.accentColor)
                    }

                    if let onFeedbackClicked = applicationInformation.onFeedbackClicked {
                        ODSButton(text: "Feedback", image: Image("ic_comments", bundle: Bundle.ods), emphasis: .lowest, action: onFeedbackClicked)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color.accentColor)
                    }
                }
                .padding(.vertical, -ODSSpacing.m)
                .padding(.leading, -ODSSpacing.m)
            }

            if let version = fullVersionText {
                VStack(alignment: .leading) {
                    Text(version)
                    Text(applicationInformation.copyrightNotice)
                }
                .fixedSize(horizontal: false, vertical: true)
            }

            if let description = applicationInformation.description {
                Text(description).fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    // =============
    // MARK: Helpers
    // =============

    private var fullVersionText: String? {
        guard let version = applicationInformation.version else {
            return nil
        }

        return "Version \(version.marketingVersion)\(buildSuffix)"
    }
    private var buildSuffix: String {
        guard let buildNumber = applicationInformation.version?.buildNumber,
              !buildNumber.isEmpty else {
            return ""
        }
        return " (\(buildNumber))\(buildTypeSuffix)"
    }
    private var buildTypeSuffix: String {
        guard let buildType = applicationInformation.version?.buildType,
              !buildType.isEmpty else {
            return ""
        }
        return " - \(buildType)"
    }
}

#if DEBUG
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        let appInfo = ODSAboutApplicationInformation(
            name: "APP NAME",
            version: ODSApplicationVersion(marketingVersion: "1.0.0", buildNumber: "123456789", buildType: "ALPHA"),
            description: "This is the demo application for test")

        ForEach(ColorScheme.allCases, id: \.self) {
            AboutApplicationInformation(applicationInformation: appInfo)
                    .preferredColorScheme($0)
        }
    }
}
#endif
