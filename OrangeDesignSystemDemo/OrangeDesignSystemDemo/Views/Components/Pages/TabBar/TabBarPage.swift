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

struct TabBarComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Bars - tab"
        image = Image("Tab bar")
        description = "A tab bar is a constantly available element which creates an overall navigation for users' experience."
        
        variants = AnyView(TabBarVariants())
    }
}

private struct TabBarVariants: View {

    var body: some View {
        VariantEntryItem(text: "Bars - tab demo", technicalElement: "TabView") {
            TabBarVariant(model: TabBarVariantModel())
                .navigationTitle("Bars - tab demo")
        }
    }
}

private struct TabBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: TabBarVariantModel
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                VStack {
                    TabView {
                        ForEach(model.availableItems, id: \.text) { itemDescription in
                            tabBarItem(from: itemDescription)
                                .modifier(BadgeModifier(badgeOption: model.badgeOption))
                        }
                    }
                }
                .border(.gray)
                
                Spacer().frame(height: 350)
            }

            .padding(.horizontal, ODSSpacing.m)
            
            BottomSheet {
                TabBarVariantBottomSheet()
            }
            .environmentObject(model)
        }
    }
    
    // =============
    // MARK: Helpers
    // =============
    
    private func tabBarItem(from itemDescription: TabBarVariantModel.ItemDescription) -> some View {
        Text(itemDescription.contentText)
            .tabItem {
                Label(itemDescription.text, systemImage: itemDescription.iconName)
            }
    }
}

private struct BadgeModifier: ViewModifier {
    
    // ======================
    // MARK: Store properties
    // ======================

    let badgeOption: TabBarVariantModel.BadgeOption

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        if badgeOption == .none {
            content
        }
        if badgeOption == .text {
            content.badge("Text")
        }
        if badgeOption == .count {
            content.badge(10)
        }
    }
}

#if DEBUG
struct TabBarPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    TabBarVariants()
                }
            }
        }
    }
}
#endif

