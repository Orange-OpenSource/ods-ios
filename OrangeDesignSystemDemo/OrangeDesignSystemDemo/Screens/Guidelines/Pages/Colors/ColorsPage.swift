/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

class ScreenState: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
}

struct ColorPageDescription: View {

    let screenState = ScreenState()

    var body: some View {
        VariantEntryItem(text: "screens.guidelines.colors.color_palette.title".🌐, technicalElement: "ODSColorPalette()") {
            ColorList().environmentObject(self.screenState)
                .navigationTitle("screens.guidelines.colors.color_palette.title")
        }
    }
}

fileprivate struct ColorList: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var phoneColorScheme
    @EnvironmentObject private var screenState: ScreenState

    private let columns = [
        GridItem(.flexible(minimum: 50.0)),
        GridItem(.flexible(minimum: 50.0))
    ]
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Group {
                Picker("Favorite Scheme", selection: $screenState.colorScheme, content: {
                    Text("screens.guidelines.colors.color_palette.on_light").tag(ColorScheme.light)
                    Text("screens.guidelines.colors.color_palette.on_dark").tag(ColorScheme.dark)
                })
                .pickerStyle(.segmented)
                .onAppear {
                    screenState.colorScheme = phoneColorScheme
                }
                .padding(EdgeInsets(top: ODSSpacing.s, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))
            }
            .padding(.top, ODSSpacing.s)

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(theme.colorPalette, id: \.assetName) { colorDescription in
                        ColorIllustration(colorDescription: colorDescription,
                                          bordered: colorDescription.uiColor.rgba() == backGroundColor.rgba())
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.vertical, ODSSpacing.m)
            }
            .background(Color(backGroundColor))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    ColorUsage()
                } ) {
                    Text("misc.usage")
                }
                .foregroundColor(theme.componentColors.navigationBarForeground)
            }
        }
        .navigationTitle("screens.guidelines.colors.palette.title")
    }
    
    // ============================
    // MARK: Private Implementation
    // ============================

    private var backGroundColor: UIColor {
        screenState.colorScheme == .light ? .white : .black
    }
}

#if DEBUG
struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorPageDescription().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
#endif
