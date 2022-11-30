---
layout: detail
title: Banners
description: A banner displays an important message which requires an action to be dismissed.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [No button](#no-button)
    * [One button](#on-button)
    * [Two buttons](#two-buttons)

---

## Specifications references

- [Design System Manager - Banners](https://system.design.orange.com/0c1af118d/p/85a52b-components/b/1497a4)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

### No button

```swift
ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
         image: Image("ods_empty", bundle: Bundle.ods))
```

### One button

* Placed next to the text

```swift
ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
         image: Image("ods_empty", bundle: Bundle.ods),
         button: ODSButton(text: "Button", emphasis: .low) {}, 
         position: .trailing)
```

* Placed under the text

```swift
ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
         image: Image("ods_empty", bundle: Bundle.ods),
         button: ODSButton(text: "Button", emphasis: .low) {}, 
         position: .bottom)
```

### Two buttons

```swift
ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
         image: Image("ods_empty", bundle: Bundle.ods),
         leadingButton: ODSButton(text: "Button 1", emphasis: .low) {},
         trailingButton: ODSButton(text: "Button 2", emphasis: .low) {})
```


