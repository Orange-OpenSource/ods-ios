//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import BottomSheet

extension ODSBottomSheetSize: CaseIterable {
    public static var allCases: [ODSBottomSheetSize] = [
        .hidden, .small, .medium, .large,
    ]

    var position: BottomSheetPosition {
        switch self {
        case .hidden:
            return .hidden
        case .small:
            return .dynamicBottom
        case .medium:
            return .relative(0.5)
        case .large:
            return .relativeTop(0.975)
        }
    }

    static var positions: [BottomSheetPosition] {
        Self.allCases.map { $0.position }
    }

    init(from position: BottomSheetPosition) {
        switch position {
        case .hidden:
            self = .hidden
        case .dynamicBottom:
            self = .small
        case let .relative(ratio) where ratio == 0.5:
            self = .medium
        default:
            self = .large
        }
    }
}

#if DEBUG
extension BottomSheetPosition {
    public var description: String {
        switch self {
        case let .absolute(s):
            return "absolute (\(s))"
        case .hidden:
            return "Hidden"
        case .dynamicBottom:
            return "dynamicBottom"
        case .dynamic:
            return "dynamic"
        case .dynamicTop:
            return "dynamicTop"
        case let .relativeBottom(s):
            return "dynamicBottom(\(s))"
        case let .relative(s):
            return "relative(\(s))"
        case let .relativeTop(s):
            return "relativeTop(\(s))"
        case let .absoluteBottom(s):
            return "absoluteBottom(\(s))"
        case let .absoluteTop(s):
            return "absoluteTop(\(s))"
        }
    }
}
#endif
