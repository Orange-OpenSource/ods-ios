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

struct BottomSheetComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "AA Sheet: Bottom"
        imageName = "BottomSheet"
        description = "By default, a sheet is modal, presenting a focused experience that prevents users from interacting with the parent view, until they dismiss the sheet. A modal sheet is useful for requesting a specific information or enabling a simple task."
        variants = AnyView(BottomSheetVariants())
    }
}

struct BottomSheetVariants: View {
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VariantEntryItem(text: "Bottom sheet", technicalElement: "ODSBottomSheet()") {
            BottomSheetVariantHome(model: BottomSheetVariantModel())
                .navigationTitle("Bottom sheet")
        }
    }
}

private struct BottomSheetVariantHome: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject private var model: BottomSheetVariantModel
    @State private var showBottomSheet = false
    
    // =================
    // MARK: Initializer
    // =================
    
    init(model: BottomSheetVariantModel) {
        self.model = model
    }
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Text("Customize the bottom sheet before opening sheet to see it.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)
            
            BottomSheetVariantOptions(model: model)
            
            ODSButton(text: "See the component", emphasis: .highest, variableWidth: false) {
                showBottomSheet = true
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.top, ODSSpacing.m)
            
            Spacer()
            
            NavigationLink(
                destination: BottomSheetVariant(model: model),
                isActive: $showBottomSheet,
                label: { EmptyView() }
            )
        }
        .padding(.vertical, ODSSpacing.m)
    }
}

struct BottomSheetVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    let model: BottomSheetVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            pageContent()
            
            ODSBottomSheet(title: "Title",
                           subtile: model.subtitle,
                           icon: model.icon,
                           detent: model.detent) {
                buttonSheetContent()
            }
        }
        .navigationBarTitle("Coucou", displayMode: .inline)
    }
    
    private func pageContent() -> some View {
        ScrollView {
            Text("""
                 To open or close  the bottom sheet :\n
                 Drag the handle up or down\n
                 Scroll the content\n
                 Tap the dimming area
                """
            )
        }
    }
    
    private func buttonSheetContent() -> some View {
        List {
            ForEach(model.exampleItemsModel, id: \.id) { itemModel in
                ODSListStandardItem(model: itemModel)
                    .padding(.horizontal, ODSSpacing.s)
                    .listRowSeparator(Visibility.visible)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)

    }
}
