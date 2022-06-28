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

// ===========
// MARK: Chips
// ===========

/// <a href="https://zeroheight.com/3b9fee398/p/67a9e8-chips/b/604d19" target="_blank">ODS Chips</a>.
///
/// Chips are small components containing a number of elements that represent a calendar event or contact.
///
/// - parameter text Text to display in the chip.
/// - parameter selected The current selection value of the chip.
/// - parameter disabled When disabled, chip will not respond to user input. It will also appear visually
/// disabled and disabled to accessibility services.
/// - parameter removable To add the remove cross to allow a chip to be removed from a list of chips.
/// - parameter thumbnail Optional right thumbnail.
///
public class ODSChipModel: Identifiable, CustomDebugStringConvertible {
    public var id: UUID
    public var text: String
    public var selected: Bool
    public var disabled: Bool
    public var removable: Bool
    public var thumbnail: ODSChipThumbnail?

    // swiftlint:disable multiline_parameters_brackets
    public init(text: String,
                thumbnail: ODSChipThumbnail? = nil,
                selected: Bool = false,
                disabled: Bool = false,
                removable: Bool = false)
    {
        id = UUID()
        self.text = text
        self.thumbnail = thumbnail
        self.selected = selected
        self.disabled = disabled
        self.removable = removable
    }

    public var debugDescription: String {
        "Name: \(text)\n"
            + "selected: \(selected)\n"
            + "removale: \(removable)\n"
            + "disabled: \(disabled)\n"
    }
}

/// If chips are added in a list, the selection can be single or multiple.
public enum ODSChipsSelectionType {
    case multiple
    case single
}

/// A thumbnail can be added on the right side of a chip.
/// - Icon is a simple image with only one color
/// - Avatar is the a more complex image like contact photo.
public enum ODSChipThumbnail {
    case icon(Image)
    case iconSystem(name: String)
    case avatar(Image)
}

// ===========
// MARK: Views
// ===========
/// The view used to display a chips in a horizontal scrollable list.
///
/// - parameter chips Model of all chips in the list
/// - parameter selectionType The type of chip selection.
/// - parameter onChipSelected When the chip is clicked and the selection state has changed.
/// - parameter onChipRemoved When the remove cross is clicked and the chip has been removed from the list.

public struct ODSChipsView: View {
    private let chips: [ODSChipModel]
    private var selectionType: ODSChipsSelectionType
    private let onChipTapped: (ODSChipModel) -> Void
    private let onChipRemoved: (ODSChipModel) -> Void

    public init(chips: [ODSChipModel], selectionType: ODSChipsSelectionType, onChipTapped: @escaping (ODSChipModel) -> Void, onChipRemoved: @escaping (ODSChipModel) -> Void) {
        self.chips = chips
        self.selectionType = selectionType
        self.onChipTapped = onChipTapped
        self.onChipRemoved = onChipRemoved
    }

    public var body: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 0) {
                HStack {
                    ForEach(chips, id: \.id) { chip in
                        ODSChipView(
                            chip: chip) { chip in
                                select(chip)
                                onChipTapped(chip)
                            } onChipRemoved: { chip in
                                onChipRemoved(chip)
                            }
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 10)
            }
            .padding(.vertical, 8)
        }
    }

    private func select(_ chip: ODSChipModel) {
        switch selectionType {
        case .multiple:
            break
        case .single:
            for chip in chips {
                chip.selected = false
            }
        }

        chip.selected.toggle()
    }
}

/// The view used to display a chip according to its model `ODSChipModel`
/// - parameter chip The model defines the chip elements (text, thumbnail) and state
/// - parameter onChipSelected On the chip is clicked and the selection state will change.
/// - parameter onChipRemoved On the close cross is clicked and the chip will removed from a list.
public struct ODSChipView: View {
    let chip: ODSChipModel
    let onChipSelected: (ODSChipModel) -> Void
    let onChipRemoved: (ODSChipModel) -> Void

    public init(chip: ODSChipModel,
                onChipSelected: @escaping (ODSChipModel) -> Void,
                onChipRemoved: @escaping (ODSChipModel) -> Void)
    {
        self.chip = chip
        self.onChipSelected = onChipSelected
        self.onChipRemoved = onChipRemoved
    }

    @State var textHeight: CGFloat = 16.0

    public var body: some View {
        VStack {
            Button {
                onChipSelected(chip)
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    if let thumbnail = chip.thumbnail {
                        ChipThumbnail(selected: chip.selected, thumbnail: thumbnail, height: textHeight)
                    }

                    HStack(spacing: 0) {
                        Text(chip.text)
                            .odsFont(style: .subhead)
                            .tint(chip.selected ? .black : .primary)
                            .padding(.vertical, 6)
                            .padding(.leading, textLeadingPadding)
                            .padding(.trailing, chip.removable ? 8 : 16)
                            .readSize { size in
                                textHeight = size.height
                            }

                        if chip.removable {
                            ClosseButtonLabel(height: textHeight, selected: chip.selected)
                                .highPriorityGesture(TapGesture().onEnded {
                                    self.onChipRemoved(chip)
                                })
                        }
                    }
                }
                .background(background)
                .clipShape(Capsule())
                .disabled(chip.disabled)
            }
        }
    }

    var textLeadingPadding: CGFloat {
        switch chip.thumbnail {
        case .icon: return 8.0
        case .avatar: return chip.selected ? 8 : 6
        case .iconSystem: return 8
        case .none: return 16.0
        }
    }

    @ViewBuilder var background: some View {
        if chip.selected {
            Capsule().foregroundColor(ODSColor.coreOrange.color)
        } else {
            Capsule().stroke(lineWidth: 1)
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
                SelectedAvatar(height: height)
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
                .accentColor(selected ? .black : .primary)
                .frame(width: height - 9, height: height - 9, alignment: .center)
                .padding(.leading, 7)

        case let .iconSystem(name):
            Image(systemName: name)
                .tint(selected ? .black : .primary)
                .padding(.leading, 8)
        }
    }
}

struct SelectedAvatar: View {
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

struct ClosseButtonLabel: View {

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

struct Chips_Previews: PreviewProvider {

    struct ChipSelectionTest: View {
        @State var chips = [
            ODSChipModel(text: "Chip 1", selected: false),
            ODSChipModel(text: "Chip _ 2", thumbnail: .iconSystem(name: "heart"), selected: false),
            ODSChipModel(text: "Chip 3", selected: false, removable: true),
            ODSChipModel(text: "Chip 4", selected: false, disabled: true),
        ]

        @State var lastSelectedChipMessage: String = ""
        @State var lastSelectedChip: UUID?

        var body: some View {
            VStack {
                ODSChipsView(chips: chips, selectionType: .multiple) { chip in
                    lastSelectedChipMessage = "\(chip.text) is \(chip.selected ? "Selected" : "Unselected")"
                    self.lastSelectedChip = chip.id
                } onChipRemoved: { chip in
                    if chip.selected {
                        lastSelectedChip = nil
                        lastSelectedChipMessage = ""
                    }

                    self.chips = chips.filter {
                        $0.id != chip.id
                    }
                }

                Text(lastSelectedChipMessage)
            }
        }
    }

    static var previews: some View {
        ChipSelectionTest()
    }
}
