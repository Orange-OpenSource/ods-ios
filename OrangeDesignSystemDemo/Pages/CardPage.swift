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

class CardPageModel: ObservableObject {

    var showImage: Bool {
        selectedCardItemFilter.contains { $0 == .showImage }
    }

    var showSubtitle: Bool {
        selectedCardItemFilter.contains { $0 == .showSubtitle }
    }

    var showDescription: Bool {
        selectedCardItemFilter.contains { $0 == .showDescription }
    }

    var showButton: Bool {
        selectedCardItemFilter.contains { $0 == .showButton }
    }

    enum CardItemFilter: Int {
        case showImage = 0
        case showSubtitle
        case showDescription
        case showButton
    }

    let cardItemFilterChips: [ODSChip<CardItemFilter>]

    @Published var selectedCardItemFilter: [CardItemFilter]

    init() {
        cardItemFilterChips = [
            ODSChip(.showImage, text: "Show Image"),
            ODSChip(.showSubtitle, text: "Show Subtitle"),
            ODSChip(.showDescription, text: "Show Description"),
            ODSChip(.showButton, text: "Show Button"),
        ]
        selectedCardItemFilter = [.showImage]
    }

    func resetSwitches() {
        selectedCardItemFilter = [.showImage]
    }

    var example: ODSCardModel {
        ODSCardModel(
            title: "Title",
            image: showImage ? "Cards" : nil,
            subTitle: showSubtitle ? ODSCardModel.example.subTitle : "",
            description: showDescription ? ODSCardModel.example.description : "")
    }
}

struct CardImageFirst: View {

    @ObservedObject var model: CardPageModel

    var body: some View {
        ZStack {
            // Card demonstrator
            ScrollView {
                ODSCardImageFirst(element: model.example) {
                    if model.showButton {
                        Button {} label: {
                            ODSGenericButtonContent(topText: "Button", textColor: ODSColor.coreBlack.color)
                        }
                        .buttonStyle(ODSFilledButtonStyle())
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
                .navigationTitle("Card Image First")
            }

            BottomSheet {
                CardBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
}

struct CardPage: View {

    @ObservedObject var model: CardPageModel
    @State var showCardImageFirst: Bool = false

    init() {
        model = CardPageModel()
    }

    var body: some View {

        List {
            VStack {
                Image("Cards_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ComponentDescription(text: "Cards are a contained and independent element that can display content and actions on a single topic.")
                    .padding(.bottom, ODSSpacing.l)
                    .padding(.horizontal, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, 0)

            NavigationLink {
                CardImageFirst(model: model)
            } label: {
                ODSListItem(model: ODSListItemModel(title: "Card Image First"))
            }

            NavigationLink {
                Text("Soon available")
            } label: {
                ODSListItem(model: ODSListItemModel(title: "Card Title First"))
            }

            NavigationLink {
                Text("Soon available")
            } label: {
                ODSListItem(model: ODSListItemModel(title: "Small card"))
            }
        }
        .listRowSeparator(Visibility.visible)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .background(ODSColor.componentBackground2.color)
    }
}

struct CardBottomSheetContent: View {

    @EnvironmentObject var model: CardPageModel

    var body: some View {
        ODSChipPicker(title: "Update card content", selection: $model.selectedCardItemFilter, allowZeroSelection: true, chips: model.cardItemFilterChips)
            .padding(.horizontal, ODSSpacing.none)
            .padding(.vertical, ODSSpacing.s)
    }
}

#if DEBUG
struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardPage()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            CardPage()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
