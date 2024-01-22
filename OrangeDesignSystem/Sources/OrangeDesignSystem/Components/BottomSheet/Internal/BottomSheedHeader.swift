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

import SwiftUI

struct BottomSheedHeader: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let subtitle: String?
    let icon: Image?
    let applyRotation: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: ODSSpacing.none) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 55, height: 4, alignment: .center)
                    .padding(.top, ODSSpacing.s)
                    .padding(.bottom, ODSSpacing.xs)

                VStack(spacing: ODSSpacing.none) {
                    HStack(spacing: ODSSpacing.xs) {
                        icon?
                            .foregroundColor(.primary)
                            .accessibility(hidden: true)
                            .odsFont(.headlineS)
                            .animation(.linear, value: applyRotation)
                            .rotationEffect(.degrees(applyRotation ? 180 : 0))

                        VStack(alignment: .leading, spacing: ODSSpacing.none) {
                            Text(title)
                                .odsFont(.headlineS)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let subtitle = self.subtitle {
                                Text(subtitle)
                                    .odsFont(.bodyS)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.leading, ODSSpacing.s)
                    .padding(.trailing, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)
                }
            }
            .background(Color(.systemGray6))
            .padding(.bottom, 10)
            .cornerRadius(10)
            .shadow(color: Color(UIColor.systemGray), radius: 4)
            .padding(.bottom, -10)
            .padding(.top, 10)
            .mask(Rectangle().padding(.top, -40))

            Divider()
        }
    }
}

#if DEBUG
struct HeaderPreviewProvider_Previews: PreviewProvider {

    struct AnimatinoExample: View {
        @State var applyRotation = false

        var body: some View {
            BottomSheedHeader(title: "Rotation: \(applyRotation ? "Yes" : "No")", subtitle: nil, icon: Image(systemName: "chevron.up"), applyRotation: applyRotation)
                .onTapGesture {
                    applyRotation.toggle()
                }

            ODSButton(text: Text(applyRotation ? "Remove Rotation" : "Apply Rotation"), emphasis: .high) {
                applyRotation.toggle()
            }
        }
    }

    static var previews: some View {
        VStack(spacing: 50) {
            VStack {
                Text("Title and Subtile")
                    .odsFont(.titleM)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: "Subtitle", icon: nil, applyRotation: false)
            }

            VStack {
                Text("Title and icon (without rotation)")
                    .odsFont(.titleM)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: nil, icon: Image(systemName: "chevron.down"), applyRotation: false)
            }

            VStack {
                Text("Title and icon (with rotation)")
                    .odsFont(.titleM)
                    .frame(maxWidth: .infinity, alignment: .leading)
                BottomSheedHeader(title: "Title", subtitle: nil, icon: Image(systemName: "chevron.down"), applyRotation: true)
            }

            VStack {
                Text("Title and icon (animated rotation)")
                    .odsFont(.titleM)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AnimatinoExample()
            }
        }
        .padding(.horizontal, 16)
    }
}
#endif
