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

struct ToolBarComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Bars - tool"
        image = Image("Tool bar")
        description = "A toolbar allows users to do specific actions regarding the entire page. It is placed at the bottom of the screen."
        
        variants = AnyView(ToolBarVariants())
    }
}

private struct ToolBarVariants: View {
    
    var body: some View {
        VariantEntryItem(text: "Bars - tool bar demo", technicalElement: "odsToolBar()") {
            ToolBarVariantHome(model: ToolBarVariantModel())
                .navigationTitle("Bars - tool bar demo")
        }
    }
}

private struct ToolBarVariantHome: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject private var model: ToolBarVariantModel
    @State private var showToolBar = false
    
    // =================
    // MARK: Initializer
    // =================
    
    init(model: ToolBarVariantModel) {
        self.model = model
    }
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        ZStack {
            VStack {
                Text("Customize the tool bar before opening sheet to see it.")
                
                ODSButton(text: "Open sheet", emphasis: .highest, variableWidth: false) {
                    showToolBar = true
                }
                
                Spacer()
            }
            .padding(.all, ODSSpacing.m)
            
            
            BottomSheet {
                ToolBarVariantBottomSheet()
            }
            .environmentObject(model)
        }
        .sheet(isPresented: $showToolBar) {
            ToolBarVariant(model: model)
        }
    }
}


private struct ToolBarVariant: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject private var model: ToolBarVariantModel
    @Environment(\.dismiss) private var dismiss
    @State private var showTextInToast: String?
    
    // =================
    // MARK: Initializer
    // =================
    
    init(model: ToolBarVariantModel) {
        self.model = model
    }
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        NavigationView {
            ZStack {
                // Add a toast to see which item is clicked
                VStack {
                    Spacer()
                    Toast(showText: $showTextInToast).padding(.bottom, 50)
                }

                // The Content view with right items in tool bar
                VStack(spacing: ODSSpacing.m) {
                    
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 55, height: 4, alignment: .center)
                        .padding(.top, ODSSpacing.s)
                        .padding(.bottom, ODSSpacing.xs)
                    
                    Spacer()
                    
                    ODSButton(text: "Close sheet", emphasis: .highest, variableWidth: false) {
                        dismiss()
                    }

                    Spacer()
                    
                    switch model.itemType {
                    case .label:
                        Text("Tool Bar with labels")
                            .odsToolBar(items: labelItems)
                    case .icon:
                        Text("Tool Bar with icons")
                            .odsToolBar(items: iconItems)
                    }
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.bottom, ODSSpacing.m)
        }
    }
    
    private func showToast(with text: String) {
        showTextInToast = "\(text): clicked"
    }
    
    var labelItems: (ODSToolbarLabeledItems) {
       
        let (item1, item2, item3) = model.availableLableItems
        let description1 = ODSToolbarLabelDesription(text: item1) {
            showToast(with: item1)
        }
        let description2 = ODSToolbarLabelDesription(text: item2) {
            showToast(with: item2)
        }
        
        var description3: ODSToolbarLabelDesription?
        
        if let item3 = item3 {
            description3 = ODSToolbarLabelDesription(text: item3) {
                showToast(with: item3)
            }
        }
        
        return ODSToolbarLabeledItems(description1: description1,
                                      description2: description2,
                                      description3: description3)
    }
    
    var iconItems: (ODSToolbarIconsItems) {
       
        let (item1, item2, item3, item4, item5) = model.availableIconItems
        let description1 = ODSToolbarIconDesription(systemName: item1) {
            showToast(with: "icon 1")
        }
        let description2 = ODSToolbarIconDesription(systemName: item2) {
            showToast(with: "icon 2")
        }
        var description3: ODSToolbarIconDesription?
        var description4: ODSToolbarIconDesription?
        var description5: ODSToolbarIconDesription?
        
        if let item3 = item3 {
            description3 = ODSToolbarIconDesription(systemName: item3) {
                showToast(with: "icon 3")
            }
        }
        if let item4 = item4 {
            description4 = ODSToolbarIconDesription(systemName: item4) {
                showToast(with: "icon 4")
            }
        }
        if let item5 = item5 {
            description5 = ODSToolbarIconDesription(systemName: item5) {
                showToast(with: "icon 5")
            }
        }
        
        return ODSToolbarIconsItems(description1: description1,
                                    description2: description2,
                                    description3: description3,
                                    description4: description4,
                                    description5: description5)
    }
}

#if DEBUG
struct ToolBarPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    ToolBarVariants()
                }
            }
        }
    }
}
#endif

