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

import Combine
import OrangeDesignSystem
import SwiftUI

class ThemeSelectionModel: ObservableObject {

    @Published var selectedThmeName: String?

    private var subscriptions = Set<AnyCancellable>()

    init() {
        selectedThmeName = ODSThemeLoader.shared.theme.name

        $selectedThmeName.sink { _ in
        } receiveValue: { themeName in
            guard let themeName = themeName else {
                return
            }

            ODSThemeLoader.shared.switchTo(themeName: themeName)
        }
        .store(in: &subscriptions)
    }
}

struct ThemeSelection: View {

    var body: some View {
        ThemeSelectionInner(model: ThemeSelectionModel())
    }
}

struct ThemeSelectionInner: View {

    @ObservedObject var model: ThemeSelectionModel

    var themes: [ODSChip<String>] {
        ODSCustomThemes.allCases.map { theme in
            ODSChip(theme.rawValue, text: theme.rawValue)
        }
    }

    var body: some View {
        VStack {
            ODSChipPicker(title: "Theme selection",
                          selection: $model.selectedThmeName,
                          chips: themes)

            Text("Selected theme")
                .odsFont(.bodyRegular)
                .foregroundColor(odsCurrentTheme.colors.bottomNavigationBarContentSelected)

            Spacer()
        }
    }
}
