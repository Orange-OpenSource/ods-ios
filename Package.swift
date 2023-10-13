// swift-tools-version:5.5

/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
        .package(url: "https://github.com/lucaszischka/BottomSheet", .exact("3.1.0")),
        .package(url: "https://github.com/Orange-OpenSource/accessibility-statement-lib-ios.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "OrangeDesignSystem",
            dependencies: ["BottomSheet",
                           .product(name: "DeclarationAccessibility", package: "accessibility-statement-lib-ios")
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
