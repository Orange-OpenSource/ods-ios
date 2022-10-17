//
//  File.swift
//  
//
//  Created by Ludovic PINEL on 14/10/2022.
//

import SwiftUI

// MARK: Theme EnvironmentKey
private struct ThemeKey: EnvironmentKey {

    static let defaultValue: ODSTheme = ODSTheme()
}

// MARK: Theme Environment value 

extension EnvironmentValues {
    public var theme: ODSTheme {
        get {
            self[ThemeKey.self]
        }
        set {
            self[ThemeKey.self] = newValue
        }
    }
}
