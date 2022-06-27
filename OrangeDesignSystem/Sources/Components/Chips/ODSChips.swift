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
public enum ODSChipsSelectionType {
    case multiple
    case single
}

public enum ODSChipAvatar {
    case icon(Image)
    case iconSystem(name: String)
    case image(Image)
}

public protocol ODSChipProtocol: Identifiable, CustomDebugStringConvertible where Self: AnyObject {
    var id: UUID { get set }
    var text: String { get set }
    var selected: Bool { get set }
    var disabled: Bool { get set }
    var removable: Bool { get set }
    var avatar: ODSChipAvatar? { get set }
}

extension ODSChipProtocol {
    public var debugDescription: String {
        "Name: \(text)\n"
            + "selected: \(selected)\n"
    }
}

public class ODSGenericChip: ODSChipProtocol {
    public var id: UUID
    public var text: String
    public var selected: Bool
    public var disabled: Bool
    public var removable: Bool
    public var avatar: ODSChipAvatar?

    public init(text: String,
                avatar: ODSChipAvatar? = nil,
                selected: Bool = false,
                disabled: Bool = false,
                removable: Bool = false)
    {
        id = UUID()
        self.text = text
        self.avatar = avatar
        self.selected = selected
        self.disabled = disabled
        self.removable = removable
    }
}

public struct ODSChipsView<T: ODSChipProtocol>: View {
    private let chips: [T]
    private var selectionType: ODSChipsSelectionType
    private let onChipTapped: (T) -> Void
    private let onChipRemoved: (T) -> Void

    public init(chips: [T], selectionType: ODSChipsSelectionType, onChipTapped: @escaping (T) -> Void, onChipRemoved: @escaping (T) -> Void) {
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
            }.padding(.vertical, 8)
        }
    }

    private func select(_ chip: T) {
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

public struct ODSChipView<T: ODSChipProtocol>: View {
    let chip: T
    let onChipSelected: (T) -> Void
    let onChipRemoved: (T) -> Void

    public init(chip: T,
                onChipSelected: @escaping (T) -> Void,
                onChipRemoved: @escaping (T) -> Void)
    {
        self.chip = chip
        self.onChipSelected = onChipSelected
        self.onChipRemoved = onChipRemoved
        selected = chip.selected
    }

    @State var textHeight: CGFloat = 16.0
    @State var selected: Bool

    public var body: some View {
        VStack {
            Button {
                selected.toggle()
                onChipSelected(chip)
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    if let avatar = chip.avatar {
                        ChipAvatarView(avatar: avatar, selected: chip.selected)
                            .frame(width: textHeight, height: textHeight, alignment: .center)
                    }

                    HStack(spacing: 8) {
                        Text(chip.text)
                            .tint(chip.selected ? .black : .primary)
                            .padding(.vertical, 6)
                            .readSize { size in
                                textHeight = size.height
                            }

                        if chip.removable {
                            ChipCloseView(selected: chip.selected)
                                .frame(width: textHeight - 6, height: textHeight - 6, alignment: .center)
                        }
                    }
                }
                .padding(.leading, leadingPadding)
                .padding(.trailing, chip.removable ? 8 : 16)
            }
            .background(background(chip.selected))
//            .clipShape(Capsule())
            .disabled(chip.disabled)
        }
    }

    var leadingPadding: CGFloat {
        switch chip.avatar {
        case .none: return 16
        case .image: return 4
        case .icon, .iconSystem: return 8
        }
    }

    @ViewBuilder func background(_ selected: Bool) -> some View {
        if selected {
            Capsule()
                .fill(ODSColor.coreOrange.color)
        } else {
            Capsule().stroke(lineWidth: 2).tint(chip.selected ? .black : .primary)
        }
    }
}

struct ChipCloseView: View {
    let selected: Bool

    var body: some View {
//        Image(systemName: "xmark.circle.fill")
        Image("Chips_cross_for_extract", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fill)
            .foregroundColor(selected ? ODSColor.coreOrange.color : Color(UIColor.systemBackground))
            .background(selected ? Color.black : .primary)
            .clipShape(Circle())
            .padding(.vertical, 7)
    }
}

struct ChipAvatarView: View {
    let avatar: ODSChipAvatar
    let selected: Bool

    var body: some View {
        switch avatar {
        case let .image(image):
            if selected {
                Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .tint(ODSColor.coreOrange.color)
                    .background(Color.black)
                    .clipShape(Circle())
                    .padding(.leading, 4)
                    .padding(.trailing, 7)
                    .padding(.vertical, 4)
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.leading, 4)
                    .padding(.trailing, 7)
                    .padding(.vertical, 4)
            }

        case let .icon(image):
            image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tint(selected ? .black : .primary)
                .padding(.leading, 8)
                .padding(.trailing, 7)
                .padding(.vertical, 7)

        case let .iconSystem(name):
            Image(systemName: name)
                .tint(selected ? .black : .primary)
                .padding(.horizontal, 8)
        }
    }
}

struct Chips_Previews: PreviewProvider {

    struct ChipSelectionTest: View {
        @State var chips = [
            ODSGenericChip(text: "Chip 1", selected: false),
            ODSGenericChip(text: "Chip _ 2", avatar: .image(Image(systemName: "heart")), selected: false),
            ODSGenericChip(text: "Chip 3", selected: false, removable: true),
            ODSGenericChip(text: "Chip 4", selected: false, disabled: true),
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
