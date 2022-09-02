---
layout: detail
title: Buttons - standard
description: A standard button is based on ODSGenericButtonContent
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [Icon add button](#icon-add-button)
    * [Icon info button](#icon-info-button)
    * [Label button](#label-button)

---

## Specifications references

- [Design System Manager - Buttons](https://system.design.orange.com/0c1af118d/p/278734-buttons-shape/b/536b5f)
- [Apple guideline - Buttons](https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/buttons)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

### Icon add button

Plain buttons are the most ubiquitous component found throughout applications. Consisting of either a text label or an icon, they are the most simple button style. 
Icon add button is based on `ODSGenericButtonContent` with `plus.circle` apple system icon

```swift
let imageDescription = ODSImageDescription(image: 
    Image(systemName: "plus.circle").renderingMode(.template),
        imageWidth: 30,
        imageHeight: 30,
        foregroundColor: ODSColor.coreOrange.color)

Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription)
}
``` 

### Icon info button

Icon Info button is identical to Icon add button with `info.circle` apple system icon 

```swift
let imageDescription = ODSImageDescription(image: 
    Image(systemName: "info.circle").renderingMode(.template),
        imageWidth: 30,
        imageHeight: 30,
        foregroundColor: ODSColor.coreOrange.color)

Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription)
}
``` 

### Label button

Label button is a simple label button with Orange theme. It is based on `ODSGenericButtonContent` with a top text

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(topText: "Button label", textColor: ODSColor.coreOrange.color)
}
``` 
