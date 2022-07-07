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
        ODSChipModel(text: "Enable"),
        ODSChipModel(text: "Selected", selected: true),
        ODSChipModel(text: "Disabled", disabled: true, removable: false),
    ]

    @State var textOnlyRemovableChips: [ODSChipModel] = [
        ODSChipModel(text: "Enable", removable: true),
        ODSChipModel(text: "Selected", selected: true, removable: true),
        ODSChipModel(text: "Disabled", disabled: true, removable: true),
    ]

    // Chips with icons
    @State var withIconChips = [
        ODSChipModel(text: "Enable", thumbnail: .icon(iconImage)),
        ODSChipModel(text: "Selected", thumbnail: .icon(iconImage), selected: true),
        ODSChipModel(text: "Disabled", thumbnail: .icon(iconImage), disabled: true),
    ]
    @State var withIconRemovabeleChips = [
        ODSChipModel(text: "Enable", thumbnail: .icon(iconImage), removable: true),
        ODSChipModel(text: "Selected", thumbnail: .icon(iconImage), selected: true, removable: true),
        ODSChipModel(text: "Disabled", thumbnail: .icon(iconImage), disabled: true, removable: true),
    ]

    // System icons
    @State var withSystemIconChips = [
        ODSChipModel(text: "Enable", thumbnail: .iconSystem(name: "heart")),
        ODSChipModel(text: "Selected", thumbnail: .iconSystem(name: "heart"), selected: true),
        ODSChipModel(text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true),
    ]

    @State var withSystemIconRemovaleChips = [
        ODSChipModel(text: "Enable", thumbnail: .iconSystem(name: "heart"), removable: true),
        ODSChipModel(text: "Selected", thumbnail: .iconSystem(name: "heart"), selected: true, removable: true),
        ODSChipModel(text: "Disabled", thumbnail: .iconSystem(name: "heart"), disabled: true, removable: true),
    ]

    // Chips with avatar
    @State var withAvatarChips = [
        ODSChipModel(text: "Enable", thumbnail: .avatar(avatarImage)),
        ODSChipModel(text: "Selected", thumbnail: .avatar(avatarImage), selected: true),
        ODSChipModel(text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true),
    ]
    @State var withAvatarRemovaleChips = [
        ODSChipModel(text: "Enable", thumbnail: .avatar(avatarImage), removable: true),
        ODSChipModel(text: "Selected", thumbnail: .avatar(avatarImage), selected: true, removable: true),
        ODSChipModel(text: "Disabled", thumbnail: .avatar(avatarImage), disabled: true, removable: true),
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
                GroupedChips(title: "With icon from image", chips: $withIconChips, removableChips: $withIconRemovabeleChips)
                GroupedChips(title: "With system icon", chips: $withSystemIconChips, removableChips: $withSystemIconRemovaleChips)
                GroupedChips(title: "With avatar", chips: $withAvatarChips, removableChips: $withAvatarRemovaleChips)
            }
            .padding(EdgeInsets(top: ODSSpacing.none, leading: ODSSpacing.m, bottom: ODSSpacing.m, trailing: ODSSpacing.m))
        }
        .background(ODSColor.primaryBackground.color)
    }
}

struct GroupedChips: View {

    let title: String
    var chips: Binding<[ODSChipModel]>
    var removableChips: Binding<[ODSChipModel]>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.title2).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
                HorizontalChipsListView(chips: chips.wrappedValue)
                HorizontalChipsListView(chips: removableChips.wrappedValue)
            }
            .padding(.horizontal, -ODSSpacing.m)
        }
    }
}

struct HorizontalChipsListView: View {
    let chips: [ODSChipModel]

    init(chips: [ODSChipModel]) {
        self.chips = chips
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ODSSpacing.s) {
                ForEach(chips, id: \.id) { chip in
                    ODSChipView(chip: chip) { _ in
                        print("Selected chip: \(chip)")
                    } onChipRemoved: { _ in
                        print("Removed chip: \(chip)")
                    }
                }
            }.padding(.top, ODSSpacing.s)
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
