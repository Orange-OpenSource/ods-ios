## Introduction

Orange is providing a full Design System to build Orange Mobile Application. The objective of the [Orange Design System](https://system.design.orange.com/0c1af118d/p/95b685-ios/) (ODS) is to propose a set of guidelines on how to apply the Orange Brand on mobile applications. The Orange design System also provides a series of components and modules that show in details how to use this in the Orange apps.

The Orange Design System has been implemented in a code library that provides:
- a SwiftUI code library
- a demo app that can be launched to show the guidelines, components and modules
- this demo app also shows how to use the lib or style existing components

Using these resources will allow you to create Orange branded applications faster and will inherit all the work that was done to make sure that all presented codes are fully tested regarding the brand and the accessibility compliance.

The Orange Design System framework supports iOS 15 and later.

## Instructions

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding ODS as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/Orange-OpenSource/ods-ios.git", .upToNextMajor(from: "0.4.1"))
]
``` 

