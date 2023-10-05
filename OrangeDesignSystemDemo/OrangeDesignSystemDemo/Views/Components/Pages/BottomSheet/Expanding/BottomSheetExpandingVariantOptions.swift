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
import OrangeDesignSystem

class BottomSheetVariantModel: ObservableObject {
    
    // ======================
    // MARK: Store properties
    // ======================

    @Published var bottomSheetSize: ODSBottomSheetSize
    @Published var contentType: ContentType
    @Published var showSubtitle: Bool {
        didSet { if showSubtitle { showIcon = false } }
    }
    @Published var showIcon: Bool {
        didSet { if showIcon { showSubtitle = false } }
    }
    
    @Published var selectedRecipe: Recipe?


    // =================
    // MARK: Initializer
    // =================

    init() {
        self.bottomSheetSize = .medium
        self.showSubtitle = false
        self.showIcon = false
        self.contentType = .tutorial
        self.selectedRecipe = RecipeBook.shared.recipes[0]
    }
    
    // ==============
    // MARK: Tutorial
    // ==============

    var tutorialTextOnPageContent: String? {
        switch bottomSheetSize {
        case .hidden, .large:
            return nil
        case .small:
            return
                """
                To open the bottom sheet :\n
                Drag the component up
                """
        case .medium:
            return
                """
                To open or close the bottom sheet :\n
                Drag the handle up or down\n
                Scroll the content\n
                Tap the dimming area
                """
        }
    }
    
    var tutorialTextOnBottomSheetContent: String? {
        switch bottomSheetSize {
        case .hidden, .small, .medium:
            return nil
        case .large:
            return
                """
                To close the bottom sheet :\n
                Drag the handle down\n
                Scroll the content\n
                Tap the dimming area
                """
        }
    }
}

struct ExpandingBottomSheetVariantHome: View {
    
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
        ScrollView {
            VStack(spacing: ODSSpacing.m) {
                Text("Customize the bottom sheet before opening sheet to see it.")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)
                
                ExpandingBottomSheetVariantOptions(model: model)
                
                ODSButton(text: "See the component", emphasis: .high, fullWidth: true) {
                    showBottomSheet = true
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
                
                Spacer()
                
                // First solution: Show Variant in navigation
//                NavigationLink(
//                    destination:
//                        BottomSheetVariant(model: model)
//                        .navigationBarTitle("Sheet: Bottom tutorial", displayMode: .inline),
//                    isActive: $showBottomSheet,
//                    label: { EmptyView() }
//                )
            }
            // Second solution: Show Variant in full screen
            .fullScreenCover(isPresented: $showBottomSheet) {
                NavigationView {
                    BottomSheetVariant(model: model)
                        .navigationBarTitle("Sheet: Bottom \(model.contentType.rawValue)", displayMode: .inline)
                        .navigationbarMenuForThemeSelection()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    showBottomSheet = false
                                } label: {
                                        Text("Close")
                                }
                            }
                        }
                }
            }
            .padding(.vertical, ODSSpacing.m)
        }
    }
}


struct ExpandingBottomSheetVariantOptions: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: BottomSheetVariantModel
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                ODSChipPicker(title: "Detent",
                              selection: $model.bottomSheetSize,
                              chips: ODSBottomSheetSize.chips)

                ODSChipPicker(title: "Content",
                              selection: $model.contentType,
                              chips: ContentType.chips)

                Toggle("Subtitle", isOn: $model.showSubtitle)
                    .padding(.horizontal, ODSSpacing.m)
                    .disabled(model.showIcon)

                Toggle("Icon", isOn: $model.showIcon)
                    .padding(.horizontal, ODSSpacing.m)
                    .disabled(model.showSubtitle)
            }
        }
        .odsFont(.bodyRegular)
    }
}


// MARK: - Internal type and extension

enum ContentType: String, CaseIterable {
    case tutorial
    case example

    var chip: ODSChip<Self> {
        ODSChip(self, text: self.rawValue.capitalized)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

extension ODSBottomSheetSize {
    var description: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .hidden:
            return "Hidden"
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases
            .filter { $0 != .hidden }
            .map { $0.chip }
    }
}
