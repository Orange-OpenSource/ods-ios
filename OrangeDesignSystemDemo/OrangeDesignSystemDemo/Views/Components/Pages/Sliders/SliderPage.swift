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

struct SliderComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Sliders"
        image = Image("Slider")
        description =  "Sliders allow users to select a single value or a range of values by moving a handle along a horizontal track."
        variants = AnyView(SliderVariants())
    }
}

struct SliderVariants: View {
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VariantEntryItem(text: "Sliders demo", technicalElement: "ODSSlider()") {
            SliderVariant(model: SliderVariantModel())
            .navigationTitle("Sliders demo")
        }
    }
}


struct SliderVariant: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: SliderVariantModel
    @State private var value = 50.0
    let range = 0 ... 100.0

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if model.showValue {
                        Text(String(format: "%.2f", value))
                            .odsFont(.bodyRegular)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityHidden(true)
                    }
                    
                    ODSSlider(value: $value, range: range, step: step) {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                    } maximumLabelView: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                    }
                    .accessibilityLabel(Text("Volume"))
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
            }

            BottomSheet(showContent: false) {
                SliderBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
    
    // =====================
    // MARK: Private Helpers
    // =====================
    
    private var step: Double {
        return model.stepped ? 5.0 : 1.0
    }
    
    struct SliderLabel: View {
        let show: Bool
        let systemName: String
        
        var body: some View {
            if show {
                Image(systemName: systemName).accessibilityHidden(true)
            }
        }
    }
}


#if DEBUG
struct SliderPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    SliderVariants()
                }
            }
        }
    }
}
#endif
