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

struct AppNewsList: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let releaseDescriptions: [AboutReleaseDescription]

    // =================
    // MARK: Initializer
    // =================

    init(fromFile path: String) {
        self.releaseDescriptions = (try? AboutReleaseDescriptionsLoader().load(from: path)) ?? []
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            if releaseDescriptions.isEmpty {
                Text("No App news found in file")
            } else {
                ForEach(releaseDescriptions, id: \.version) { releaseDescription in
                    AboutReleaaseDescriptionEntry(releaseDescription: releaseDescription)
                        .padding(.horizontal, ODSSpacing.m)
                    Divider()
                }
            }
        }
    }
}

private struct AboutReleaaseDescriptionEntry: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let releaseDescription: AboutReleaseDescription

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {
            HStack {
                Text(releaseDescription.version).odsFont(.headline)
                Spacer()
                Text(formatedDate).odsFont(.caption1Regular)
            }

            Text(releaseDescription.news)
                .odsFont(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, ODSSpacing.s)
    }

    // ====================
    // MARK: Private Helper
    // ====================

    private var formatedDate: String {
        releaseDescription.date.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.omitted)
    }
}
