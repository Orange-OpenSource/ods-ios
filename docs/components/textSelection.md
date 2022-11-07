---
layout: detail
title: Text edit menu
description: Text selection with theme colors
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Text selection example](#text-selection-example)

---

## Specifications references

- [Design System Manager - Text fields](https://system.design.orange.com/0c1af118d/p/47d389-text-fields/b/461794)
- [Apple guideline - Text fields](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/text-fields)
- [Apple guideline - Edit Menu](https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/edit-menus)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Text selection example

Text selection is available when text field or text editor is entering in edition mode. This is not a custom component but just a way to customize the component with color provided by theme.

```swift
TextField("A text field", text: $textToEdit)
        .accentColor(theme.componentColors.accent)
```

**Remark:** If the accent color is set on the root view, no need to apply it again. 
