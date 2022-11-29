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

import OrangeDesignSystem
import SwiftUI

struct ProgressIndicatorComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Progress indicators"
        image = Image("Progress_indicator")
        description =  "Progress indicators show users that elements or pages are loading."
        
        variants = AnyView(ProgressIndicatorVariants())
    }
}

private struct ProgressIndicatorVariants: View {
    
    var body: some View {
        VariantEntryItem(text: "Progress bar", technicalElement: "ProgressView(value:, total:)") {
            ProgressBarVariant()
                .navigationTitle("Progress bar")
        }
        VariantEntryItem(text: "Progress indicator", technicalElement: "ProgressView()") {
            ProgressIndicatorVariant()
                .navigationTitle("Progress indicator")
        }
    }
}


private struct ProgressBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================
    @Environment(\.theme) private var theme
    
    @State private var secondsElapsed = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let maxSeconds: CGFloat = 100.0
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            ProgressView("Downloading…", value: secondsElapsed, total: maxSeconds)
                .tint(theme.componentColors.accent)
                .onReceive(timer) { _ in
                    if secondsElapsed < maxSeconds {
                        secondsElapsed += 1
                    } else {
                        secondsElapsed = 0
                    }
                }
            
            Spacer()
        }
        .padding(.all, ODSSpacing.m)
    }
}

struct ProgressIndicatorVariant: View {

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            ProgressView() {
                Text("Loading...")
            }
            Spacer()
        }
        .padding(.all, ODSSpacing.m)
    }
}

#if DEBUG
struct ProgressIndicatorPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    ProgressIndicatorVariants()
                }
            }
        }
    }
}
#endif
