//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
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
