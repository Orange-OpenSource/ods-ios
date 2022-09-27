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

class CardImageFirstModelPage: ObservableObject {

    var showSubtitle: Bool {
        selectedCardItemFilter.contains { $0 == .showSubtitle }
    }

    var showSupportingText: Bool {
        selectedCardItemFilter.contains { $0 == .showSupportingText }
    }

    var showButton: Bool {
        selectedCardItemFilter.contains { $0 == .showButton }
    }

    enum CardItemFilter: Int {
        case showSubtitle = 0
        case showSupportingText
        case showButton
    }

    let cardItemFilterChips: [ODSChip<CardItemFilter>]

    @Published var selectedCardItemFilter: [CardItemFilter]

    init() {
        cardItemFilterChips = [
            ODSChip(.showSubtitle, text: "Show subtitle"),
            ODSChip(.showSupportingText, text: "Show supporting text"),
            ODSChip(.showButton, text: "Show buttons"),
        ]
        selectedCardItemFilter = [.showSubtitle, .showSupportingText, .showButton]
    }

    func resetSwitches() {
        selectedCardItemFilter = [.showSubtitle, .showSupportingText, .showButton]
    }

    var cardModel: ODSCardImageFirstModel {
        ODSCardImageFirstModel(
            title: cardExampleTitle,
            subtitle: showSubtitle ? cardExampleSubtitle : nil,
            image: Image("ods_empty", bundle: Bundle.ods),
            supportingText: showSupportingText ? cardExampleSupportingText : nil)
    }
}

struct CardImageFirstPage: View {

    @ObservedObject var model: CardImageFirstModelPage

    var body: some View {
        ZStack {
            // Card demonstrator
            ScrollView {
                ODSCardImageFirst(model: model.cardModel) {
                    if model.showButton {
                        Button {} label: {
                            ODSGenericButtonContent(topText: "Button")
                        }
                        .buttonStyle(ODSBorderedButtonStyle())
                    }
                } buttonContent2: {
                    if model.showButton {
                        Button {} label: {
                            ODSGenericButtonContent(topText: "Button")
                        }
                        .buttonStyle(ODSBorderedButtonStyle())
                    }
                }
                .padding(.horizontal, ODSSpacing.s)
                .padding(.top, ODSSpacing.m)
            }
            .navigationTitle("Card Image First")

            BottomSheet(showContent: false) {
                CardImageFirstBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
}

struct CardImageFirstBottomSheetContent: View {

    @EnvironmentObject var model: CardImageFirstModelPage

    var body: some View {
        ODSChipPicker(title: "Update card content", selection: $model.selectedCardItemFilter, allowZeroSelection: true, chips: model.cardItemFilterChips)
            .padding(.horizontal, ODSSpacing.none)
            .padding(.vertical, ODSSpacing.s)
    }
}
