//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

// =======================
// MARK: - Chips Component
// =======================

struct ChipsComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        title = °°"screens.components.chips.title"
        imageName = "Chips"
        description = °°"screens.components.chips.description"
        variants = AnyView(ChipsVariants())
    }
}

// ======================
// MARK: - Chips Variants
// ======================

struct ChipsVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.chips.variant.picker".🌐, technicalElement: "ODSChipPicker()") {
            ChipPickerVariants(model: ChipsVariantModel())
                .navigationTitle("screens.components.chips.variant.picker".🌐)
        }

        VariantEntryItem(title: "screens.components.chips.variant.choice".🌐, technicalElement: "ODSChoiceChip()") {
            ChoiceChipVariant(model: ChoiceChipVariantModel())
                .navigationTitle("screens.components.chips.variant.choice".🌐)
        }
    }
}

struct ChipPickerVariants: View {

    @ObservedObject var model: ChipsVariantModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                GroupedChips(title: °°"screens.components.chips.text_only",
                             chips: model.textOnlyChips,
                             removableChips: model.textOnlyRemovableChips,
                             selection: $model.selectedTextOnlyChip,
                             selectionRemovableChips: $model.selectedTextOnlyRemovableChip)

                GroupedChips(title: °°"screens.components.chips.with_icon",
                             chips: model.withIconChips,
                             removableChips: model.withIconRemovableChips,
                             selection: $model.selectedWithIconChip,
                             selectionRemovableChips: $model.selectedWithIconRemovableChip)

                GroupedChips(title: °°"screens.components.chips.with_system_icon",
                             chips: model.withSystemIconChips,
                             removableChips: model.withSystemIconRemovableChips,
                             selection: $model.selectedWithSystemIconChip,
                             selectionRemovableChips: $model.selectedWithSystemIconRemovableChip)

                GroupedChips(title: °°"screens.components.chips.with_avatar",
                             chips: model.withAvatarChips,
                             removableChips: model.withAvatarRemovableChips,
                             selection: $model.selectedWithAvatarChip,
                             selectionRemovableChips: $model.selectedWithAvatarRemovableChip)
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}

// =====================
// MARK: - Grouped Chips
// =====================

struct GroupedChips<ChipNotRemovable, ChipRemovable>: View where ChipNotRemovable: Hashable, ChipRemovable: Hashable {

    let title: String
    var chips: [ODSChip<ChipNotRemovable>]
    var removableChips: [ODSChip<ChipRemovable>]

    let selection: Binding<ChipNotRemovable?>
    let selectionRemovableChips: Binding<ChipRemovable?>

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            Text(title).odsFont(.titleM).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: ODSSpacing.s) {
                ODSChipPicker(selection: selection, chips: chips)
                ODSChipPicker(selection: selectionRemovableChips, chips: removableChips)
            }
            .padding(.horizontal, -ODSSpacing.m)
        }
    }
}

#if DEBUG
struct ChipsViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChipsVariants()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            ChipsVariants()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
