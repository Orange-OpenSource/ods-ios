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

class ListHeitghtChip: ODSGenericChip {

    var height: ODSListItemMinHeight

    init(heightDescription: String, height: ODSListItemMinHeight, isSelected: Bool = false) {
        self.height = height
        super.init(name: heightDescription, isSelected: isSelected)
    }
}

struct Chips_Previews: PreviewProvider {

    struct ChipSelectionTest: View {
        let chips = [
            ODSGenericChip(name: "Chip 1", isSelected: false),
            ODSGenericChip(name: "Chip 2", isSelected: false),
            ODSGenericChip(name: "Chip 3", isSelected: false),
            ODSGenericChip(name: "Chip 4", isSelected: false),
        ]

        @State var lastSelectedChipMessage: String = ""

        var body: some View {
            VStack {
                ODSChipsView(chips: chips, selectionType: .multiple) { chip in
                    lastSelectedChipMessage = "\(chip.name) is \(chip.isSelected ? "Selected" : "Unselected")"
                }

                Text(lastSelectedChipMessage)
            }
        }
    }

    static var previews: some View {
        ChipSelectionTest()
    }
}

// ===========
// MARK: Chips
// ===========
public enum ODSChipsSelectionType {
    case multiple
    case single
}

public protocol ODSChipProtocol: Identifiable where Self: AnyObject {
    var id: String { get set }
    var name: String { get set }
    var isSelected: Bool { get set }
}

public class ODSGenericChip: ODSChipProtocol {
    public var id: String
    public var name: String
    public var isSelected: Bool

    public init(name: String, isSelected: Bool = false) {
        id = UUID().uuidString
        self.name = name
        self.isSelected = isSelected
    }
}

public struct ODSChipsView<T: ODSChipProtocol>: View {
    private let chips: [T]
    private var selectionType: ODSChipsSelectionType
    private let onChipTapped: (T) -> Void

    public init(chips: [T], selectionType: ODSChipsSelectionType, onChipTapped: @escaping (T) -> Void) {
        self.chips = chips
        self.selectionType = selectionType
        self.onChipTapped = onChipTapped
    }

    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(chips, id: \.id) { chip in
                    ODSChipView(
                        chip: chip,
                        isSelected: chip.isSelected) { chip in
                            select(chip)
                            onChipTapped(chip)
                        }
                }
            }
            .padding(.horizontal, 8)
            .padding(.leading, 5)
            .padding(.trailing, 10)
        }
    }

    private func select(_ chip: T) {
        switch selectionType {
        case .multiple:
            break
        case .single:
            for chip in chips {
                chip.isSelected = false
            }
        }

        chip.isSelected.toggle()
    }
}

struct ODSChipView<T: ODSChipProtocol>: View {
    let chip: T
    let isSelected: Bool
    let onChipSelected: (T) -> Void

    init(chip: T,
         isSelected: Bool,
         onChipSelected: @escaping (T) -> Void)
    {
        self.chip = chip
        self.isSelected = isSelected
        self.onChipSelected = onChipSelected
    }

    var body: some View {
        VStack {
            Button {
                onChipSelected(chip)
            } label: {
                ODSGenericButtonContent(bottomText: chip.name, textColor:
                    isSelected ? ODSColor.coreOrange.color : .primary)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Capsule().stroke(Color.black, lineWidth: 2))
                    .clipShape(Capsule())
            }
        }
    }
}
