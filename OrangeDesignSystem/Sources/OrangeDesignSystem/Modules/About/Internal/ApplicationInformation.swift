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

            if applicationInformation.shareUrl != nil || applicationInformation.onFeedbackClicked != nil {
                HStack(spacing: ODSSpacing.none) {
                    if let shareUrl = applicationInformation.shareUrl {
                        ODSButton(text: "Share", image: Image("ic_share", bundle: Bundle.ods), emphasis: .low) {
                            ShareSheet.show(content: "The content", subject: "The subject", url: shareUrl)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.accentColor)
                    }

                    if let onFeedbackClicked = applicationInformation.onFeedbackClicked {
                        ODSButton(text: "Feedback", image: Image("ic_comments", bundle: Bundle.ods), emphasis: .low, action: onFeedbackClicked)
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

        return "Version \(versionWithBuildNumber(version: version))"
    }

    private func versionWithBuildNumber(version: String) -> String {
        var versionAndBuildNumber: String {
            if let buildNumber = applicationInformation.buildNumber {
                return "\(version) (\(buildNumber))"
            } else {
                return version
            }
        }

        if let buildType = applicationInformation.buildType {
            return "\(versionAndBuildNumber) - \(buildType)"
        } else {
            return versionAndBuildNumber
        }
    }
}

#if DEBUG
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        let description = ApplicationInformation(name: "APP NAME",
                                                 version: "1.0.0",
                                                 buildNumber: "123456789",
                                                 buildType: "DEBUG",
                                                 description: "This is the demo application for test")

        ForEach(ColorScheme.allCases, id: \.self) {

            AboutView()
                .preferredColorScheme($0)
                .environmentObject(description)
        }
    }
}
#endif
