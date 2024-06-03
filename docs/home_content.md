## Introduction

Orange is providing a full Design System to build Orange Mobile Application. The objective of the [Orange Design System](https://system.design.orange.com/0c1af118d/p/95b685-ios/) (ODS) is to propose a set of guidelines on how to apply the Orange Brand on mobile applications. The Orange design System also provides a series of components and modules that show in details how to use this in the Orange apps.

The Orange Design System has been implemented in a code library that provides:
- a SwiftUI code library
- a demo app that can be launched to show the guidelines, components and modules
- this demo app also shows how to use the lib or style existing components

Using these resources will allow you to create Orange branded applications faster and will inherit all the work that was done to make sure that all presented codes are fully tested regarding the brand and the accessibility compliance.

The Orange Design System framework supports **iOS 15 and later**.

## Instructions

1. Depend on our library

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding ODS as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` and add products into your targets:
- OrangeDesignSystem for the core of the library
- OrangeTheme for the theme of the orange brand 

```swift
dependencies: [
    .package(url: "https://github.com/Orange-OpenSource/ods-ios.git", .upToNextMajor(from: "1.1.0"))
],
targets: [
    .target(name: "MyLibrary", dependencies: [
        .product(name: "OrangeDesignSystem", package: "ods-ios"),
        .product(name: "OrangeTheme", package: "ods-ios")]),
``` 

2 Change your app theme to inherit from a Orange Design theme

Because ODS support multi-theme, you should pass the __OrangeTheme__ as theme configuration to use the Orange theme.
Note that Orange theme supports both light and dark mode.

Use the ODSThemeableView as your main Content view which will add the theme in the environement, update navigationbar and tabbar according to colors stored in the theme object. 


```swift
@main
struct YourApplication: App {
    
    var body: some Scene {
        WindowGroup {
            ODSThemeableView(theme: OrangeThemeFactory().theme) {
                ContentView()
            }
        }
    }
}

Note: Use another provided __ODSTheme__ implementation if you want to use a custom theme. For example __InnovationCupThemeFactory().theme__.

3. Internationalization

Today, the __OrangeDesignSystem__ core library does not define any strings. But some modules (like About) define their own strings in the default language (English).
In order to translate those strings in a new language, you need to insert into the Localizable.strings file of your application, the keys define by modules and the associated traduction.
