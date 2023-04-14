---
layout: detail
title: Bottom sheets
description: Bottom Sheets are surfaces anchored to the bottom of the screen that present users supplement content.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
  * [Standard](#standard)
  * [Expanding](#expanding)

---

## Specifications references

- [Design System Manager - Bottom sheets](https://system.design.orange.com/0c1af118d/p/3347ca-sheets-bottom/b/83b619)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

Bottom sheets are surfaces anchored to the bottom of the screen that present users supplemental content.
It is useful for requesting a specific information or enabling a simple task related to the current context
of the current view or more globaly the application context.

### Standard

The standard bottom sheet must be used only with a "simple, basic" content. If a more complex content (scrollable) must be added prefer the Expanding variant.

It defines two states:
- **closed**: The content is hidden
- **opened**: The content is visible (above the main view)

A taps on the header, opens or closes the bottom sheet.

```swift
struct BottomSheetPresentation: View {
    @State private var isOpen = false
    
    var body: some View {
        VStack {
            //  Main content goes here.
            Text("Bottom sheet is \(isOpen ? "Opened": "Closed")")
        }
        .odsBottomSheetStandard(isOpen: $isOpen, title: "Customize") {
            // Bottom sheet content goes here
        }
    }
}
```

### Expanding

The type of bottom must be used if the content is more complex and perhaps need to be scrollable.

It defines three size:
- **small**: (closed) The content is hidden, only the header is visible
- **medium**: (parcially opened) The content is parcially visible (half screen above the main view) but not scrollable 
- **large**: (opened) The content is visible and scrollable

User can resize by tapping on dimming area (close), drag the content, or tap on the header to cycle through the available sizes. 

```swift
    struct BottomSheetPresentation: View {
        @State private var bottomSheetSize: ODSBottomSheetSize = .large
        var body: some View {
            VStack {
                // Main content goes here.
                Text("Bottom sheet size \(bottomSheetSize.rawValue)")
            }
            .odsBottomSheetExpanding(title: "Customize", bottomSheetSize: $bottomSheetSize) {
                // Bottom sheet content goes here
            }
        }
    }
```

**Remark**: In order to compute the resizing when user scrolls the content, the bottom sheet automatically adds the provided content is a scrollView.      

