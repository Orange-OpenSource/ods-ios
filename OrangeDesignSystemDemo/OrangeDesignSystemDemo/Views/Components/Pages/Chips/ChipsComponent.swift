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

import OrangeDesignSystem
import SwiftUI

struct ChipsComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Chips"
        image = Image("Chips")
        description = "Chips are small components containing a number of elements that represent a calendar event or contact."
        
        variants = AnyView(ChipsVariants(model: ChipsVariantModel()))
    }
}

struct ChipsVariants: View {

    @ObservedObject var model: ChipsVariantModel

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
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
    }
}

struct GroupedChips<ChipNotRemovable, ChipRemovable>: View where ChipNotRemovable: Hashable, ChipRemovable: Hashable {

    let title: String
    var chips: [ODSChip<ChipNotRemovable>]
    var removableChips: [ODSChip<ChipRemovable>]

    let selection: Binding<ChipNotRemovable?>
    let selectionRemovableChips: Binding<ChipRemovable?>

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            Text(title).odsFont(.title2).frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
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
