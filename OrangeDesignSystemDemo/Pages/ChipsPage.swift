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

import Foundation
import OrangeDesignSystem
import SwiftUI

let avatarImage = Image("avatar", bundle: Bundle.main)
let iconImage = Image("iconsFunctionalUiEMIcHeartRecommend", bundle: Bundle.main)

class ChipsPageModel: ObservableObject {

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

    let textOnlyChips: [OODSChip<TextOnlyChip>]
    let textOnlyRemovableChips: [OODSChip<TextOnlyRemovableChip>]

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

    let withIconChips: [OODSChip<WithIconChip>]
    let withIconRemovableChips: [OODSChip<WithIconRemovableChip>]

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

    let withSystemIconChips: [OODSChip<WithSystemIconChip>]
    let withSystemIconRemovableChips: [OODSChip<WithSystemIconRemovableChip>]

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

    let withAvatarChips: [OODSChip<WithAvatarChip>]
    let withAvatarRemovableChips: [OODSChip<WithAvatarRemovableChip>]

    @Published var selectedWithAvatarChip: WithAvatarChip?
    @Published var selectedWithAvatarRemovableChip: WithAvatarRemovableChip?

    init() {
        // Chips with textOnly
        textOnlyChips = [
            OODSChip(.enabled, text: "Enable"),
            OODSChip(.selected, text: "Selected"),
            OODSChip(.disabled, text: "Disabled", disabled: true),
        ]

        selectedTextOnlyChip = .selected

        textOnlyRemovableChips = [
            OODSChip(.enabled, text: "Enable", removable: true),
            OODSChip(.selected, text: "Selected", removable: true),
            OODSChip(.disabled, text: "Disabled", disabled: true, removable: true),
        ]

        selectedTextOnlyRemovableChip = .selected

        // Chips with icon
        withIconChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .icon(iconImage)),
            OODSChip(.selected, text: "Selected", thumbnail: .icon(iconImage)),
            OODSChip(.disabled, text: "Disabled", thumbnail: .icon(iconImage), disabled: true),
        ]

        selectedWithIconChip = .selected

        withIconRemovableChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .icon(iconImage), removable: true),
            OODSChip(.selected, text: "Selected", thumbnail: .icon(iconImage), removable: true),
            OODSChip(.disabled, text: "Disabled", thumbnail: .icon(iconImage), disabled: true, removable: true),
        ]

        selectedWithIconRemovableChip = .selected

        // System icons
        withSystemIconChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .iconSystem(name: "heart")),
            OODSChip(.selected, text: "Selected", thumbnail: .iconSystem(name: "heart")),
            OODSChip(.disabled, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true),
        ]

        selectedWithSystemIconChip = .selected

        withSystemIconRemovableChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .iconSystem(name: "heart"), removable: true),
            OODSChip(.selected, text: "Selected", thumbnail: .iconSystem(name: "heart"), removable: true),
            OODSChip(.disabled, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true, removable: true),
        ]
        selectedWithSystemIconRemovableChip = .selected

        // Chips with avatar
        withAvatarChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .avatar(avatarImage)),
            OODSChip(.selected, text: "Selected", thumbnail: .avatar(avatarImage)),
            OODSChip(.disabled, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true),
        ]

        selectedWithAvatarChip = .selected

        withAvatarRemovableChips = [
            OODSChip(.enabled, text: "Enable", thumbnail: .avatar(avatarImage), removable: true),
            OODSChip(.selected, text: "Selected", thumbnail: .avatar(avatarImage), removable: true),
            OODSChip(.disabled, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true, removable: true),
        ]

        selectedWithAvatarRemovableChip = .selected
    }
}

struct ChipsPage: View {

    var body: some View {
        ChipsPageInner(model: ChipsPageModel())
    }
}

struct ChipsPageInner: View {
    @ObservedObject var model: ChipsPageModel

    var body: some View {
        ScrollView {
            Image("Chips")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 16) {
                ComponentDescription(text: "Chips are small components containing a number of elements that represent a calendar event or contact.")

                VariantsTitle()

                GroupedChips(title: "Text only",
                             chips: model.textOnlyChips,
                             removableChips: model.textOnlyRemovableChips,
                             selection: $model.selectedTextOnlyChip,
                             selectionRemovableChips: $model.selectedTextOnlyRemovableChip)

                GroupedChips(title: "With icon from image",
                             chips: model.withIconChips,
                             removableChips: model.withIconRemovableChips,
                             selection: $model.selectedWithIconChip,
                             selectionRemovableChips: $model.selectedWithIconRemovableChip)

                GroupedChips(title: "With system icon",
                             chips: model.withSystemIconChips,
                             removableChips: model.withSystemIconRemovableChips,
                             selection: $model.selectedWithSystemIconChip,
                             selectionRemovableChips: $model.selectedWithSystemIconRemovableChip)

                GroupedChips(title: "With avatar",
                             chips: model.withAvatarChips,
                             removableChips: model.withAvatarRemovableChips,
                             selection: $model.selectedWithAvatarChip,
                             selectionRemovableChips: $model.selectedWithAvatarRemovableChip)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

struct GroupedChips<ChipNotRemovable, ChipRemovable>: View where ChipNotRemovable: Hashable, ChipRemovable: Hashable {

    let title: String
    var chips: [OODSChip<ChipNotRemovable>]
    var removableChips: [OODSChip<ChipRemovable>]

    let selection: Binding<ChipNotRemovable?>
    let selectionRemovableChips: Binding<ChipRemovable?>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.title2).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
                ODSChipPicker(selection: selection, chips: chips)
                ODSChipPicker(selection: selectionRemovableChips, chips: removableChips)
            }
            .padding(.horizontal, -16)
        }
    }
}

#if DEBUG
struct ChipsViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChipsPage()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            ChipsPage()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
