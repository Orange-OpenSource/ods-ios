// swift-tools-version:5.5

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

import PackageDescription

let package = Package(
    name: "OrangeDesignSystem",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "OrangeDesignSystem",
            targets: ["OrangeDesignSystem"]
        ),
        .library(
            name: "OrangeTheme",
            targets: ["OrangeTheme"]
        ),
        .library(
            name: "InnovationCupTheme",
            targets: ["InnovationCupTheme"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/tevelee/SwiftUI-Flow", .exact("1.2.0")),
        .package(url: "https://github.com/lucaszischka/BottomSheet", .exact("3.1.1")),
        .package(url: "https://github.com/Orange-OpenSource/accessibility-statement-lib-ios.git", .exact("1.0.0"))
    ],
    targets: [
        .target(
            name: "OrangeDesignSystem",
            dependencies: ["BottomSheet",
                           .product(name: "DeclarationAccessibility", package: "accessibility-statement-lib-ios"),
                           .product(name: "Flow", package: "SwiftUI-Flow"),
                           ],
            path: "OrangeDesignSystem/Sources"),
        .target(
            name: "OrangeTheme",
            dependencies: ["OrangeDesignSystem"],
            path: "OrangeTheme/Sources"),
        .target(
            name: "InnovationCupTheme",
            dependencies: ["OrangeDesignSystem"],
            path: "InnovationCupTheme/Sources"),
    ],
    swiftLanguageVersions: [.v5]
)
