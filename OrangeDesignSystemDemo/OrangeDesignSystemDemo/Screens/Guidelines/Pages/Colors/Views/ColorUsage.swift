//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import OrangeDesignSystem
import SwiftUI

struct ColorUsage: View {

    @Environment(\.theme) private var theme

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                Text("screens.guidelines.colors.description")
                    .padding(.top, ODSSpacing.s)
                Text("screens.guidelines.colors.description.more")
                    .accentColor(theme.componentColors.accent)
                    .padding(.top, ODSSpacing.m)
                // TODO: make component
            }
        }
        .padding(EdgeInsets(top: ODSSpacing.none, leading: ODSSpacing.m, bottom: ODSSpacing.m, trailing: ODSSpacing.m))
        .navigationTitle("misc.usage")
    }
}

#if DEBUG
struct ColorUsage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorUsage().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
#endif
