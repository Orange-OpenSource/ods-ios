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
    * [No button](#no_button)
    * [One button](#one_button)
    * [Two buttons](#two_buttons)

---

## Specifications references

- [Design System Manager - Banners](https://zeroheight.com/3b9fee398/v/latest/p/31627a-banners/b/3652e7)

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


