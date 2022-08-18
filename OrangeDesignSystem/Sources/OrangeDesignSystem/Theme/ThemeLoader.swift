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

public enum ODSCustomThemes: String, CaseIterable {
    case Orange
    case Primezone
}

public var odsCurrentTheme: ODSTheme {
    return ODSThemeLoader.shared.theme
}

public class ODSThemeLoader {
    public internal(set) var theme: ODSTheme
    public internal(set) var assetsBundle: Bundle

    public static let shared = ODSThemeLoader()

    private init() {
        if let selectedTheme = UserDefaults.standard.string(forKey: "ODSThemeName") {
            (theme, assetsBundle) = ODSThemeLoader.loadTheme(themeName: selectedTheme)
        } else {
            guard let themeName = Bundle.main.infoDictionary?["ODSThemeName"] as? String else {
                fatalError("No Theme name found in Info.plist")
            }

            (theme, assetsBundle) = ODSThemeLoader.loadTheme(themeName: themeName)
        }
    }

    internal static func loadTheme(themeName: String) -> (ODSTheme, Bundle) {
        switch themeName {
        case ODSCustomThemes.Orange.rawValue:
            return (OrangeTheme(), Bundle.ods)
        case ODSCustomThemes.Primezone.rawValue:
            return (PrimezoneTheme(), Bundle.ods)
        default:
            let path = "\(themeName)Theme.framework/\(themeName)Theme"

            if let result = dlopen(path, RTLD_LOCAL),
               let themeClass = NSClassFromString("\(themeName)Theme.\(themeName)Theme"),
               let currentThemeClass = themeClass as? ODSTheme.Type
            {
                let assetsBundle = Bundle(for: themeClass)
                let currentTheme = currentThemeClass.init()
                dlclose(result)
                return (currentTheme, assetsBundle)
            } else {
                fatalError("No thme found with name: \(themeName)")
            }
        }
    }

    public func switchTo(themeName: String) {
        UserDefaults.standard.set(themeName, forKey: "ODSThemeName")
        (theme, assetsBundle) = ODSThemeLoader.loadTheme(themeName: themeName)
    }
}
