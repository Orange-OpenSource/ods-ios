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
    * [Without image](#without-image)
    * [With image from url](#with-image-from-url)

---

A banner displays an important, succinct message, and provides actions for users to address (or dismiss the banner). It requires a user action to be dismissed.

Banners should be displayed at the top of the screen, below a top app bar. They’re persistent and nonmodal, allowing the user to either ignore them or interact with them at any time. Only one banner should be shown at a time

![Banner light](images/banner-light.png)
![Banner dark](images/banner-dark.png)

## Specifications references

- [Design System Manager - Banners](https://system.design.orange.com/0c1af118d/p/85a52b-components/b/1497a4)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

### No button

```swift
ODSBanner(text: "One to two lines is preferable on mobile and tablet.",
         imageSource: .image(Image("ods_empty", bundle: Bundle.ods)))
```

### One button

The button is placed under the text.

```swift
ODSBanner(text: "One to two lines is preferable on mobile and tablet.",
         imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
         button: ODSBannerButton(text: "Button") { /* your action here */}, 
)
```

### Two buttons

Button are placed under the text.

```swift
ODSBanner(text: "One to two lines is preferable on mobile and tablet.",
         imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
         firstButton: ODSBannerButton(text: "Button 1") {},
         secondButton: ODSBannerButton(text: "Button 2") {})
```

### Without image

```swift
ODSBanner(text: "One to two lines is preferable on mobile and tablet.",
         firstButton: ODSBannerButton(text: "Button 1") {},
         secondButton: ODSBannerButton(text: "Button 2") {})
```

### With image from url

```swift

let placeholder = Image("ods_empty", bundle: Bundle.ods)
let url = URL(string: "https://images.unsplash.com/photo-1615735487485-e52b9af610c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80")

ODSBanner(text: "One to two lines is preferable on mobile and tablet.",
         imageSource: .asyncImage(url, placeholder),
         firstButton: ODSBannerButton(text: "Button 1") {},
         secondButton: ODSBannerButton(text: "Button 2") {})
```


