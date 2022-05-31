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

struct ProgressIndicatorPage: View {

    var body: some View {
        ScrollView {
            Image("Progress_indicator")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "Progress indicators show users that elements or pages are loading.")
                VariantsTitle()
                ProgressBar()
                ProgressIndicator()
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Progress Indicator")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator()
    }
}

struct ProgressBar: View {
    @State private var secondsElapsed = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let maxSeconds: CGFloat = 100.0

    var body: some View {
        Text("Progress bar")
            .odsFont(style: .title2)
        ProgressView("Downloading…", value: secondsElapsed, total: maxSeconds)
            .onReceive(timer) { _ in
                if secondsElapsed < maxSeconds {
                    secondsElapsed += 1
                } else {
                    secondsElapsed = 0
                }
            }
    }
}

struct ProgressIndicator: View {
    var body: some View {
        Text("Progress indicator")
            .odsFont(style: .title2)
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}
