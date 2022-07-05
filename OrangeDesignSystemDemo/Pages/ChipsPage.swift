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

struct ChipsPage: View {
    // Chips with textOnly
    @State var selectedTextOnlyChip: ODSChip?
    @State var selectedTextOnlyRemovableChip: ODSChip?

    @State var selectedWithIconChip: ODSChip?
    @State var selectedWithIconRemovableChip: ODSChip?

    @State var selectedWithSystemIconChip: ODSChip?
    @State var selectedWithSystemIconRemovableChip: ODSChip?

    @State var selectedWithAvatarChip: ODSChip?
    @State var selectedWithAvatarRemovableChip: ODSChip?

    @State var textOnlyChips: [ODSChip]
    @State var textOnlyRemovableChips: [ODSChip]
    @State var withIconChips: [ODSChip]
    @State var withIconRemovableChips: [ODSChip]
    @State var withSystemIconChips: [ODSChip]
    @State var withSystemIconRemovableChips: [ODSChip]
    @State var withAvatarChips: [ODSChip]
    @State var withAvatarRemovaleChips: [ODSChip]

    var body: some View {
        ScrollView {
            Image("Chips")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 16) {
                ComponentDescription(text: "Chips are small components containing a number of elements that represent a calendar event or contact.")

                VariantsTitle()

                GroupedChips(title: "Text only",
                             chips: textOnlyChips,
                             removableChips: textOnlyRemovableChips,
                             selectionTypeForChips: .single($selectedTextOnlyChip, allowZeroSelection: true),
                             selectionTypeForRemovableChips: .single($selectedTextOnlyRemovableChip, allowZeroSelection: true))

                GroupedChips(title: "With icon from image",
                             chips: withIconChips,
                             removableChips: withIconRemovableChips,
                             selectionTypeForChips: .single($selectedWithIconChip, allowZeroSelection: true),
                             selectionTypeForRemovableChips: .single($selectedWithIconRemovableChip, allowZeroSelection: true))

                GroupedChips(title: "With system icon",
                             chips: withSystemIconChips,
                             removableChips: withSystemIconRemovableChips,
                             selectionTypeForChips: .single($selectedWithSystemIconChip, allowZeroSelection: true),
                             selectionTypeForRemovableChips: .single($selectedWithSystemIconRemovableChip, allowZeroSelection: true))

                GroupedChips(title: "With avatar",
                             chips: withAvatarChips,
                             removableChips: withAvatarRemovaleChips,
                             selectionTypeForChips: .single($selectedWithAvatarChip, allowZeroSelection: true),
                             selectionTypeForRemovableChips: .single($selectedWithAvatarRemovableChip, allowZeroSelection: true))
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }

    init() {
        // Chips with textOnly
        let textOnlyChips = [
            ODSChip(1, text: "Enable"),
            ODSChip(2, text: "Selected"),
            ODSChip(3, text: "Disabled", disabled: true),
        ]
        self.textOnlyChips = textOnlyChips
        _selectedTextOnlyChip = State(initialValue: textOnlyChips[1])

        let textOnlyRemovableChips = [
            ODSChip(10, text: "Enable", removable: true),
            ODSChip(11, text: "Selected", removable: true),
            ODSChip(12, text: "Disabled", disabled: true, removable: true),
        ]
        self.textOnlyRemovableChips = textOnlyRemovableChips
        _selectedTextOnlyRemovableChip = State(initialValue: textOnlyRemovableChips[1])

        let withIconChips = [
            ODSChip(20, text: "Enable", thumbnail: .icon(iconImage)),
            ODSChip(21, text: "Selected", thumbnail: .icon(iconImage)),
            ODSChip(22, text: "Disabled", thumbnail: .icon(iconImage), disabled: true),
        ]
        self.withIconChips = withIconChips
        _selectedWithIconChip = State(initialValue: withIconChips[1])

        let withIconRemovableChips = [
            ODSChip(30, text: "Enable", thumbnail: .icon(iconImage), removable: true),
            ODSChip(31, text: "Selected", thumbnail: .icon(iconImage), removable: true),
            ODSChip(32, text: "Disabled", thumbnail: .icon(iconImage), disabled: true, removable: true),
        ]
        self.withIconRemovableChips = withIconRemovableChips
        _selectedWithIconRemovableChip = State(initialValue: withIconRemovableChips[1])

        // System icons
        let withSystemIconChips = [
            ODSChip(40, text: "Enable", thumbnail: .iconSystem(name: "heart")),
            ODSChip(41, text: "Selected", thumbnail: .iconSystem(name: "heart")),
            ODSChip(42, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true),
        ]
        self.withSystemIconChips = withSystemIconChips
        _selectedWithSystemIconChip = State(initialValue: withSystemIconChips[1])

        let withSystemIconRemovableChips = [
            ODSChip(50, text: "Enable", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(51, text: "Selected", thumbnail: .iconSystem(name: "heart"), removable: true),
            ODSChip(52, text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true, removable: true),
        ]
        self.withSystemIconRemovableChips = withSystemIconRemovableChips
        _selectedWithSystemIconRemovableChip = State(initialValue: withSystemIconRemovableChips[1])

        // Chips with avatar
        let withAvatarChips = [
            ODSChip(60, text: "Enable", thumbnail: .avatar(avatarImage)),
            ODSChip(61, text: "Selected", thumbnail: .avatar(avatarImage)),
            ODSChip(62, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true),
        ]
        self.withAvatarChips = withAvatarChips
        _selectedWithAvatarChip = State(initialValue: withAvatarChips[1])

        let withAvatarRemovaleChips = [
            ODSChip(70, text: "Enable", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(71, text: "Selected", thumbnail: .avatar(avatarImage), removable: true),
            ODSChip(72, text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true, removable: true),
        ]
        self.withAvatarRemovaleChips = withAvatarRemovaleChips
        _selectedWithAvatarRemovableChip = State(initialValue: withAvatarRemovaleChips[1])
    }
}

struct GroupedChips: View {

    let title: String
    var chips: [ODSChip]
    var removableChips: [ODSChip]

    let selectionTypeForChips: ODSChipPickerType
    let selectionTypeForRemovableChips: ODSChipPickerType

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.title2).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
                ODSChipPicker(chips: chips, type: selectionTypeForChips)
                ODSChipPicker(chips: removableChips, type: selectionTypeForRemovableChips)
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
