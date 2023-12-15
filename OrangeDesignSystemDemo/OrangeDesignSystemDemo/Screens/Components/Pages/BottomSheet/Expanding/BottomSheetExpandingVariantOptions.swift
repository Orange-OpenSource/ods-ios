//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

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
        bottomSheetSize = .medium
        showSubtitle = false
        showIcon = false
        contentType = .tutorial

        selectedRecipe = RecipeBook.shared.recipes[0]
    }

    // ==============
    // MARK: Tutorial
    // ==============

    var tutorialTextOnPageContent: String? {
        switch bottomSheetSize {
        case .hidden, .large:
            return nil
        case .small:
            return °°"screens.components.bottom_sheets.sample.open_small"
        case .medium:
            return °°"screens.components.bottom_sheets.sample.open_medium"
        }
    }

    var tutorialTextOnBottomSheetContent: String? {
        switch bottomSheetSize {
        case .hidden, .small, .medium:
            return nil
        case .large:
            return °°"screens.components.bottom_sheets.sample.open_large"
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
                Text("screens.components.bottom_sheets.variant.customize")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)

                ExpandingBottomSheetVariantOptions(model: model)

                ODSButton(text: Text("screens.components.bottom_sheets.variant.see"), emphasis: .high, fullWidth: true) {
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
                        .navigationBarTitle("screens.components.bottom_sheets.variant.selection" <- model.contentType.rawValue, displayMode: .inline)
                        .navigationbarMenuForThemeSelection()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    showBottomSheet = false
                                } label: {
                                    Text("shared.close")
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
            ODSChoiceChipPicker(
                title: Text("screens.components.bottom_sheets.variant.detent"),
                chips: ODSBottomSheetSize.chips,
                selection: $model.bottomSheetSize)

            ODSChoiceChipPicker(
                title: Text("screens.components.bottom_sheets.variant.content"),
                chips: ContentType.chips,
                selection: $model.contentType)

            Toggle("shared.subtitle", isOn: $model.showSubtitle)
                .padding(.horizontal, ODSSpacing.m)
                .disabled(model.showIcon)

            Toggle("shared.icon", isOn: $model.showIcon)
                .padding(.horizontal, ODSSpacing.m)
                .disabled(model.showSubtitle)
        }
        .odsFont(.bodyLRegular)
    }
}

// MARK: - Internal type and extension

enum ContentType: String, CaseIterable {
    case tutorial
    case example

    var description: LocalizedStringKey {
        switch self {
        case .tutorial:
            return "screens.components.bottom_sheets.tutorial"
        case .example:
            return "screens.components.bottom_sheets.example"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

extension ODSBottomSheetSize {
    var description: LocalizedStringKey {
        switch self {
        case .small:
            return "screens.components.bottom_sheets.size.small"
        case .medium:
            return "screens.components.bottom_sheets.size.medium"
        case .large:
            return "screens.components.bottom_sheets.size.large"
        case .hidden:
            return "screens.components.bottom_sheets.size.hidden"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}
