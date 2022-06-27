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

    @State var textOnlyChips = [
        ODSGenericChip(text: "Enable1"),
        ODSGenericChip(text: "Selected1", selected: true),
        ODSGenericChip(text: "Disabled1", disabled: true, removable: false),
    ]

    @State var textOnlyRemovableChips: [ODSGenericChip] = [
        ODSGenericChip(text: "Enable2", removable: true),
        ODSGenericChip(text: "Selected2", selected: true, removable: true),
        ODSGenericChip(text: "Disabled2", disabled: true, removable: true),
    ]

    // Chips with icons
    @State var withIconChips = [
        ODSGenericChip(text: "Enable3", avatar: .icon(iconImage)),
        ODSGenericChip(text: "Selected3", avatar: .icon(iconImage), selected: true),
        ODSGenericChip(text: "Disabled3", avatar: .icon(iconImage), disabled: true),
    ]
    @State var withIconRemovabeleChips = [
        ODSGenericChip(text: "Enable4", avatar: .icon(iconImage), removable: true),
        ODSGenericChip(text: "Selected4", avatar: .icon(iconImage), selected: true, removable: true),
        ODSGenericChip(text: "Disabled4", avatar: .icon(iconImage), disabled: true, removable: true),
    ]

    // Chips with avatar
    @State var withAvatarChips = [
        ODSGenericChip(text: "Enable5", avatar: .image(avatarImage)),
        ODSGenericChip(text: "Selected5", avatar: .image(avatarImage), selected: true),
        ODSGenericChip(text: "Disabled5", avatar: .image(avatarImage), disabled: true),
    ]
    @State var withAvatarRemovaleChips = [
        ODSGenericChip(text: "Enable6", avatar: .image(avatarImage), removable: true),
        ODSGenericChip(text: "Selected6", avatar: .image(avatarImage), selected: true, removable: true),
        ODSGenericChip(text: "Disabled6", avatar: .image(avatarImage), disabled: true, removable: true),
    ]

    var body: some View {
        ScrollView {
            Image("Chips")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 16) {
                ComponentDescription(text: "Chips are small components containing a number of elements that represent a calendar event or contact.")

                VariantsTitle()

                GroupedChips(title: "Text only", chips: $textOnlyChips, removableChips: $textOnlyRemovableChips)
                GroupedChips(title: "With icon", chips: $withIconChips, removableChips: $withIconRemovabeleChips)
                GroupedChips(title: "With avatar", chips: $withAvatarChips, removableChips: $withAvatarRemovaleChips)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 5, trailing: 16))
        }
    }
}

struct GroupedChips: View {

    let title: String
    var chips: Binding<[ODSGenericChip]>
    var removableChips: Binding<[ODSGenericChip]>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.title2).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
                HorizontalChipsListView(chips: chips.wrappedValue)
                HorizontalChipsListView(chips: removableChips.wrappedValue)
            }
            .padding(.horizontal, -16)
        }
    }
}

struct HorizontalChipsListView: View {
    let chips: [ODSGenericChip]

    init(chips: [ODSGenericChip]) {
        self.chips = chips
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Spacer(minLength: 8)

                ForEach(chips, id: \.id) { chip in
                    ODSChipView(chip: chip) { _ in
                    } onChipRemoved: { _ in
                    }
                }
            }
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
