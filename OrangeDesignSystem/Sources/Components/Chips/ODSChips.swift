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

import SwiftUI

/// A thumbnail can be added on the right side of a chip.
/// - Icon is a simple image with only one color
/// - Avatar is the a more complex image like contact photo.
public enum ODSChipThumbnail {
    case icon(Image)
    case iconSystem(name: String)
    case avatar(Image)
}

/// <a href="https://zeroheight.com/3b9fee398/p/67a9e8-chips/b/604d19" target="_blank">ODS Chips</a>.
///
/// Chips are small components containing a number of elements that represent a calendar event or contact.
///
/// - parameter text Text to display in the chip.
/// - parameter thumbnail Optional right thumbnail.
/// - parameter disabled When disabled, chip will not respond to user input. It will also appear visually
/// disabled and disabled to accessibility services.
/// - parameter removable To add the remove cross to allow a chip to be removed from a list of chips.
///
public struct ODSChip {

    public let id: Int
    let text: String
    let thumbnail: ODSChipThumbnail?
    let disabled: Bool
    let removable: Bool

    public init(_ id: Int, text: String, thumbnail: ODSChipThumbnail? = nil, disabled: Bool = false, removable: Bool = false)
    {
        self.id = id
        self.text = text
        self.thumbnail = thumbnail
        self.disabled = disabled
        self.removable = removable
    }
}

/// Define the type of selection of chips in list:
/// - Parameter single: This type allows only one chip to be selected. If `allowZeroSelection`,
///  is set to true, no chip can be selected. if set to false, almost one chip is selected.
/// - Parameter multiple: This type allows multiple chips to be selected (0 to N)
///
public enum ODSChipPickerType {
    case single(Binding<ODSChip?>, allowZeroSelection: Bool)
    case multiple(Binding<[ODSChip]>)
}

/// Create a picker by providing the selection type with a binding to get selected element(s).
/// An additonnal title can be added above the Picker.
///
/// - Parameter type The type of selection
/// - Parameter chips All chips describing elements to be displayed.
/// - Parameter title Additional title if needed.
///
public struct ODSChipPicker: View {

    let title: String?
    let chips: [ODSChip]
    let type: ODSChipPickerType

    @State var textHeight: CGFloat = 30.0

    public init(title: String? = nil, chips: [ODSChip], type: ODSChipPickerType) {
        self.type = type
        self.chips = chips
        self.title = title
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title).odsFont(style: .headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {

                    HStack(spacing: 8) {
                        ForEach(chips, id: \.id) { chip in
                            Button {
                                onTapped(chip: chip)
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    if let thumbnail = chip.thumbnail {
                                        ChipThumbnail(selected: isSelected(chip),
                                                      thumbnail: thumbnail,
                                                      height: textHeight)
                                    }

                                    Text(chip.text)
                                        .odsFont(style: .subhead)
                                        .tint(isSelected(chip) ? .black : .primary)
                                        .padding(.vertical, 6)
                                        .padding(.leading, textLeadingPadding(for: chip))
                                        .padding(.trailing, false /* chip.removable*/ ? 8 : 16)
                                        .readSize { size in
                                            textHeight = size.height
                                        }

                                    if chip.removable {
                                        ChipRemoveLabel(height: textHeight, selected: isSelected(chip))
                                            .highPriorityGesture(TapGesture().onEnded {
                                                // TODO:
                                                print("TODO")
                                                //                                            self.onChipRemoved(chip)
                                            })
                                    }
                                }
                            }
                            .background(background(for: chip))
                            .clipShape(Capsule())
                            .disabled(chip.disabled)
                        }
                    }
                    .padding(.trailing, 10)
                    .padding(.leading, 16)
                }
            }
        }
    }

    func textLeadingPadding(for chip: ODSChip) -> CGFloat {
        switch chip.thumbnail {
        case .icon: return 8.0
        case .avatar: return isSelected(chip) ? 8 : 6
        case .iconSystem: return 8
        case .none: return 16.0
        }
    }

    @ViewBuilder func background(for chip: ODSChip) -> some View {
        if isSelected(chip) {
            Capsule().foregroundColor(ODSColor.coreOrange.color)
        } else {
            Capsule().stroke(lineWidth: 1)
        }
    }

    func isSelected(_ chip: ODSChip) -> Bool {
        switch type {
        case let .single(selectedChip, _):
            return chip.id == selectedChip.wrappedValue?.id
        case let .multiple(selectedChips):
            return selectedChips.wrappedValue.contains(where: { chip.id == $0.id })
        }
    }

    func onTapped(chip: ODSChip) {
        switch type {
        case let .single(bindingToSelectedChip, allowZeroSelection):
            if bindingToSelectedChip.wrappedValue?.id == chip.id {
                if allowZeroSelection {
                    bindingToSelectedChip.wrappedValue = nil
                }
            } else {
                bindingToSelectedChip.wrappedValue = chip
            }

        case let .multiple(bindingToSelectedChips):
            if let index = bindingToSelectedChips.wrappedValue.firstIndex(where: { $0.id == chip.id }) {
                bindingToSelectedChips.wrappedValue.remove(at: index)
            } else {
                bindingToSelectedChips.wrappedValue.append(chip)
            }
        }
    }
}

struct ChipThumbnail: View {
    let selected: Bool
    let thumbnail: ODSChipThumbnail
    let height: CGFloat

    var body: some View {
        switch thumbnail {
        case let .avatar(image):
            if selected {
                ChipSelectedAvatar(height: height)
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: height - 6, height: height - 6, alignment: .center)
                    .clipShape(Circle())
                    .padding(.leading, 4)
            }
        case let .icon(image):
            image
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .tint(selected ? .black : .primary)
                .frame(width: height - 9, height: height - 9, alignment: .center)
                .padding(.leading, 7)

        case let .iconSystem(name):
            Image(systemName: name)
                .tint(selected ? .black : .primary)
                .padding(.leading, 8)
        }
    }
}

struct ChipSelectedAvatar: View {
    let height: CGFloat

    var body: some View {
        Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(ODSColor.coreOrange.color)
            .background(Color.black)
            .frame(width: height - 6, height: height - 6, alignment: .center)
            .clipShape(Circle())
            .padding(.leading, 4)
    }
}

struct ChipRemoveLabel: View {

    let height: CGFloat
    let selected: Bool

    var body: some View {
        Image("Close", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(selected ? .black : .primary)
            .frame(width: height - 11, height: height - 11, alignment: .center)
            .padding(.trailing, 7.0)
    }
}

#if DEBUG
struct OODSChips_Previews: PreviewProvider {

    struct OODSChipPickerTest: View {
        @State var selectedChip: ODSChip?
        @State var selectedChips: [ODSChip] = []
        let allowZeroSelection = false

        let chips = [ODSChip(1, text: "Title 1"),
                     ODSChip(2, text: "Title 2", thumbnail: .iconSystem(name: "heart")),
                     ODSChip(3, text: "Removable 1", removable: true),
                     ODSChip(4, text: "Removable 2", thumbnail: .iconSystem(name: "heart"), removable: true),
                     ODSChip(5, text: "Disabled", disabled: true)]

        var body: some View {
            VStack {
                VStack(spacing: 10) {
                    VStack(spacing: 10) {
                        ODSChipPicker(title: "Single selection", chips: chips, type: .single($selectedChip, allowZeroSelection: allowZeroSelection))
                        Text("selected Chip : \(selectedChip?.text ?? "")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .background(ODSColor.supportingGreen100.color)

                    VStack(spacing: 10) {
                        ODSChipPicker(title: "Multiple Selection", chips: chips, type: .multiple($selectedChips))
                        Text("Selected Chip : \(self.selectedChipsText)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .background(ODSColor.supportingGreen100.color)
                }
            }
        }

        var selectedChipsText: String {
            return selectedChips.reduce(into: "") { result, chip in
                result = "\(result), \(chip.text)"
            }
        }
    }

    static var previews: some View {
        OODSChipPickerTest()
    }
}
#endif
