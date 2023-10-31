//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

class ChipsVariantModel: ObservableObject {

    // Text only section
    enum TextOnlyChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum TextOnlyRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let textOnlyChips: [ODSChip<TextOnlyChip>]
    let textOnlyRemovableChips: [ODSChip<TextOnlyRemovableChip>]

    @Published var selectedTextOnlyChip: TextOnlyChip?
    @Published var selectedTextOnlyRemovableChip: TextOnlyRemovableChip?

    // with icon section
    enum WithIconChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithIconRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withIconChips: [ODSChip<WithIconChip>]
    let withIconRemovableChips: [ODSChip<WithIconRemovableChip>]

    @Published var selectedWithIconChip: WithIconChip?
    @Published var selectedWithIconRemovableChip: WithIconRemovableChip?

    // with system icon section
    enum WithSystemIconChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithSystemIconRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withSystemIconChips: [ODSChip<WithSystemIconChip>]
    let withSystemIconRemovableChips: [ODSChip<WithSystemIconRemovableChip>]

    @Published var selectedWithSystemIconChip: WithSystemIconChip?
    @Published var selectedWithSystemIconRemovableChip: WithSystemIconRemovableChip?

    // with avatar section
    enum WithAvatarChip: Int {
        case enabled
        case selected
        case disabled
    }

    enum WithAvatarRemovableChip: Int {
        case enabled
        case selected
        case disabled
    }

    let withAvatarChips: [ODSChip<WithAvatarChip>]
    let withAvatarRemovableChips: [ODSChip<WithAvatarRemovableChip>]

    @Published var selectedWithAvatarChip: WithAvatarChip?
    @Published var selectedWithAvatarRemovableChip: WithAvatarRemovableChip?

    init() {

        let avatarImage = Image("avatar", bundle: Bundle.main)
        let iconImage = Image("iconsFunctionalUiEMIcHeartRecommend", bundle: Bundle.main)

        // Chips with textOnly
        textOnlyChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable"),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected"),
            ODSChip(.disabled, text: °°"shared.disabled", disabled: true),
        ]

        selectedTextOnlyChip = .selected

        textOnlyRemovableChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", removable: true),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", removable: true),
            ODSChip(.disabled, text: °°"shared.disabled", disabled: true, removable: true),
        ]

        selectedTextOnlyRemovableChip = .selected

        // Chips with icon
        withIconChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .icon(iconImage)),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .icon(iconImage)),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .icon(iconImage), disabled: true),
        ]

        selectedWithIconChip = .selected

        withIconRemovableChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .icon(iconImage), removable: true),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .icon(iconImage), removable: true),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .icon(iconImage), disabled: true, removable: true),
        ]

        selectedWithIconRemovableChip = .selected

        // System icons
        withSystemIconChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .iconSystem(name: "heart")),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .iconSystem(name: "heart")),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .iconSystem(name: "heart"), disabled: true),
        ]

        selectedWithSystemIconChip = .selected

        withSystemIconRemovableChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .iconSystem(name: "heart"), disabled: true, removable: true),
        ]
        selectedWithSystemIconRemovableChip = .selected

        // Chips with avatar
        withAvatarChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .avatar(avatarImage)),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .avatar(avatarImage)),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .avatar(avatarImage), disabled: true),
        ]

        selectedWithAvatarChip = .selected

        withAvatarRemovableChips = [
            ODSChip(.enabled, text: °°"screens.guidelines.chips.state.enable", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(.selected, text: °°"screens.guidelines.chips.state.selected", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(.disabled, text: °°"shared.disabled", thumbnail: .avatar(avatarImage), disabled: true, removable: true),
        ]

        selectedWithAvatarRemovableChip = .selected
    }
}
