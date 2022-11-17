---
layout: detail
title: Banners
description: A banner displays an important message which requires an action to be dismissed.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Usage](#usage)

---

## Specifications references

- [Design System Manager - Banners](https://zeroheight.com/3b9fee398/v/latest/p/31627a-banners/b/3652e7)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Usage

```swift
ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
        image: Image("ods_empty", bundle: Bundle.ods),
        button1: ODSButton(text: "Button 1", emphasis: .low) {},
        button2: ODSButton(text: "Button 2", emphasis: .low) {})
```
