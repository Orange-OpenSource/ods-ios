---
layout: detail
title: Buttons shape
description: A shaped button allows a user to perform an important call to action.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [Filled shaped button](#filled-shaped-button)
    * [Shaped button with border](#shaped-button-with-border)

---

## Specifications references

- [Design System Manager - Buttons](https://system.design.orange.com/0c1af118d/p/278734-buttons-shape/b/536b5f)
- [Apple guideline - Buttons](https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/buttons)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

A shaped button is based on `ODSGenericButtonContent` by applying predefined button style

### Filled shaped button

Filled shaped button is based on `ODSGenericButtonContent` with button style `ODSFilledButtonStyle`

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Title", bottomText: "Subtitle", textColor: ODSColor.core_black_900.color)
}
.buttonStyle(ODSFilledButtonStyle())


let imageDescription = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"),
    imageWidth: 30, 
    imageHeight: 30, 
    foregroundColor: ODSColor.core_black_900.color)
``` 

### Shaped button with border

Shaped button with border is based on `ODSGenericButtonContent` with button style `ODSBorderedButtonStyle`

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Title", bottomText: "Subtitle", textColor: ODSColor.core_black_900.color)
}
.buttonStyle(ODSBorderedButtonStyle())


let imageDescription = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"),
    imageWidth: 30, 
    imageHeight: 30, 
    foregroundColor: ODSColor.core_black_900.color)
``` 

