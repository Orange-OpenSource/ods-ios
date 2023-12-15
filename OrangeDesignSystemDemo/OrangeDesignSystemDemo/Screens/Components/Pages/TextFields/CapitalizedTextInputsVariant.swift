//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

// MARK: Variants

struct TextEditorVariant: View {

    var body: some View {
        CapitalizedTextInputsVariant(model: CapitalizedTextInputsVariantModel(inputType: .textEditor))
    }
}

struct TextFieldVariant: View {
    var body: some View {
        CapitalizedTextInputsVariant(model: CapitalizedTextInputsVariantModel(inputType: .textField))
    }
}

private struct CapitalizedTextInputsVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: CapitalizedTextInputsVariantModel
    @FocusState private var isFocused: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            VStack {
                textField
                    .textInputAutocapitalization(model.selectedCapitalizationType.textInputAutocapitalization)
                    .odsTextFieldStyle()
                    // TODO, why                   .id(model.selectedCapitalizationType.description)
                    .padding(.horizontal, ODSSpacing.s)
                    .padding(.top, ODSSpacing.m)
                    .focused($isFocused)
                    .onAppear {
                        isFocused = true
                    }

                Spacer()
            }
        } options: {
            CapitalizedTextInputsVariantOptions(model: model)
        }
    }

    // ==================
    // MARK: Initializers
    // ==================

    init(model: CapitalizedTextInputsVariantModel) {
        self.model = model

        if case .textEditor = model.inputType {
            UITextView.appearance().backgroundColor = .clear
        }
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private var textField: some View {
        switch model.inputType {
        case .textField:
            TextField(model.defaultText, text: $model.textToEdit)
        case .textEditor:
            TextEditor(text: $model.textToEdit)
        }
    }
}

private class CapitalizedTextInputsVariantModel: ObservableObject {

    // ====================
    // MARK: Internal types
    // ====================

    enum CapitalizationType: Int, CaseIterable {
        case never = 0
        case characters
        case words
        case sentences

        var textInputAutocapitalization: TextInputAutocapitalization {
            switch self {
            case .never: return .never
            case .characters: return .characters
            case .words: return .words
            case .sentences: return .sentences
            }
        }

        var description: LocalizedStringKey {
            switch self {
            case .never: return "screens.components.textfields.variants.inputs.never"
            case .characters: return "screens.components.textfields.variants.inputs.characters"
            case .words: return "screens.components.textfields.variants.inputs.words"
            case .sentences: return "screens.components.textfields.variants.inputs.sentences"
            }
        }

        var chip: ODSChoiceChip<Self> {
            .init(text: Text(description), value: self)
        }

        static var chips: [ODSChoiceChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }

    enum InputType {
        case textField
        case textEditor
    }

    // ======================
    // MARK: Store properties
    // ======================

    @Published var selectedCapitalizationType: CapitalizationType {
        didSet { reseetTextToEdit() }
    }

    @Published var textToEdit: String = ""

    var defaultText: String {
        let text = °°"screens.components.textfields.variants.inputs.default.default"
        switch selectedCapitalizationType {
        case .never:
            return text
        case .characters:
            return text.uppercased()
        case .words:
            return text.capitalized
        case .sentences:
            return °°"screens.components.textfields.variants.inputs.default.sentences"
        }
    }

    let inputType: InputType

    // ==================
    // MARK: Initializers
    // ==================

    init(inputType: InputType) {

        self.inputType = inputType
        selectedCapitalizationType = CapitalizationType.never

        reseetTextToEdit()
    }

    private func reseetTextToEdit() {
        switch inputType {
        case .textField:
            textToEdit = ""
        case .textEditor:
            textToEdit = defaultText
        }
    }
}

private struct CapitalizedTextInputsVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: CapitalizedTextInputsVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            ODSChoiceChipPicker(
                title: Text("screens.components.textfields.variants.inputs.options.capitalization"),
                chips: CapitalizedTextInputsVariantModel.CapitalizationType.chips,
                selection: $model.selectedCapitalizationType)
                .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
