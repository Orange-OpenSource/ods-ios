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
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "Bars - tool"
        imageName = "Bars - tool"
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
        ScrollView {
            VStack {
                Text("Customize the tool bar before opening sheet to see it.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)
                
                ToolBarVariantOptions(model: model)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.xl)
                
                ODSButton(text: Text("Open sheet"), emphasis: .high, fullWidth: true) {
                    showToolBar = true
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.top, ODSSpacing.m)
        }
        .sheet(isPresented: $showToolBar) {
            ToolBarVariantContent(model: model)
        }
    }
}

private struct ToolBarVariantContent: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject private var model: ToolBarVariantModel
    @Environment(\.dismiss) private var dismiss

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
            VStack(spacing: ODSSpacing.m) {
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 55, height: 4, alignment: .center)
                    .padding(.top, ODSSpacing.s)
                    .padding(.bottom, ODSSpacing.xs)
                
                Spacer()
                
                ODSButton(text: Text("Close sheet"), emphasis: .high, fullWidth: true) {
                    dismiss()
                }
                
                Spacer()
                
                switch model.itemType {
                case .label:
                    Text("Tool Bar with labels")
                    
                case .icon:
                    Text("Tool Bar with icons")
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.bottom, ODSSpacing.m)
            .navigationBarHidden(true)
            .modifier(ToolBarVariantContentModifier(model: model))
        }
        .alert(model.alertText, isPresented: $model.showAlert) {
            Button("close", role: .cancel) {}
        }
    }
}

private struct ToolBarVariantContentModifier: ViewModifier {
    
    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: ToolBarVariantModel
    
    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        switch model.itemType {
        case .label:
            content.odsToolBar(items: model.labelItems)
        case .icon:
            content.odsToolBar(items: model.iconItems)
        }
    }
}
        

#if DEBUG
struct ToolBarComponent_Previews: PreviewProvider {
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

