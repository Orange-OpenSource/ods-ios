/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
        title = "screens.guidelines.chips.title".🌐
        imageName = "Chips"
        description = "screens.guidelines.chips.description".🌐
        variants = AnyView(ChipsVariants(model: ChipsVariantModel()))
    }
}

// ======================
// MARK: - Chips Variants
// ======================

struct ChipsVariants: View {
    
    @ObservedObject var model: ChipsVariantModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            GroupedChips(title: "screens.guidelines.chips.text_only".🌐,
                         chips: model.textOnlyChips,
                         removableChips: model.textOnlyRemovableChips,
                         selection: $model.selectedTextOnlyChip,
                         selectionRemovableChips: $model.selectedTextOnlyRemovableChip)
            
            GroupedChips(title: "screens.guidelines.chips.with_icon".🌐,
                         chips: model.withIconChips,
                         removableChips: model.withIconRemovableChips,
                         selection: $model.selectedWithIconChip,
                         selectionRemovableChips: $model.selectedWithIconRemovableChip)
            
            GroupedChips(title: "screens.guidelines.chips.with_system_icon".🌐,
                         chips: model.withSystemIconChips,
                         removableChips: model.withSystemIconRemovableChips,
                         selection: $model.selectedWithSystemIconChip,
                         selectionRemovableChips: $model.selectedWithSystemIconRemovableChip)
            
            GroupedChips(title: "screens.guidelines.chips.with_avatar".🌐,
                         chips: model.withAvatarChips,
                         removableChips: model.withAvatarRemovableChips,
                         selection: $model.selectedWithAvatarChip,
                         selectionRemovableChips: $model.selectedWithAvatarRemovableChip)
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
            Text(title).odsFont(.title2).frame(maxWidth: .infinity, alignment: .leading)

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
            ChipsVariants(model: ChipsVariantModel())
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            ChipsVariants(model: ChipsVariantModel())
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
