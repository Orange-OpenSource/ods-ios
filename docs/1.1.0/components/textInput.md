---
layout: detail
title: Text fields and text editor
description: Text fields and text editor let users enter and edit text.
---

---

**Page Summary**

* Table of contents
{:toc}

---

## Specifications references

- [Design System Manager - Text fields](https://system.design.orange.com/0c1af118d/p/47d389-text-fields/b/461794)
- [Apple guideline - Text fields](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/text-fields)
- [Apple guideline - Edit Menu](https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/edit-menus)
- [Apple doc - Text input](https://developer.apple.com/documentation/swiftui/text-input-and-output)
- [Apple doc - Text Field](https://developer.apple.com/documentation/swiftui/textfield)
- [Apple doc - Secure Text Field](https://developer.apple.com/documentation/swiftui/securefield)
- [Apple doc - Text Editor](https://developer.apple.com/documentation/swiftui/i/texteditor)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

For all variants, we provide the `odsTextFieldStyle` view modifier to apply font, collors (background, tint) provided by the theme. 

### Text field

A control that displays an editable text interface.

```swift
TextField("A text field", text: $textToEdit)
        .odsTextFieldStyle()
```

 ### Secure text field
 
Use a `SecureField` when you want behavior similar to a ``TextField``, but you don't want the user's text to be visible. Typically, you use this for entering passwords and other sensitive information.

```swift
SecureField("Secure text", text: $textToEdit)
        .odsTextFieldStyle()
```

### Text editor

A text editor view allows you to display and edit multiline, scrollable text in your app's user interface.

```swift
TextEditor(text: $textToEdit)
        .odsTextFieldStyle()
```

## Text selection

Text selection is available when text field or text editor is entering in edition mode. This is not a custom component but just a way to apply right style (customize with colors, font provided by theme).

