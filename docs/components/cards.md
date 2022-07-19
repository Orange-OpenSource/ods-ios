---
layout: detail
title: Cards
description: Cards contain content and actions about a single subject.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [Large cards (Image first)](#large-cards-image-first)
    * [Large cards (Title first)](#large-cards-title-first)
    * [Small cards](#small-cards)
* [Component specific tokens](#component-specific-tokens)

---

## Specifications references

- [Design System Manager - Cards](https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

Cards are a contained and independent element that can display content and actions on a single topic.

### Large cards (Image first)

There are a few ways cards can be presented. Ranging from a single title on its own for a simple card view or with more information shown in a subtitle and supporting text and actions at the bottom of the card.

According to `ODSCardModel` configuration the card elements are shown or not:

- Media with title
- Media, title with subtitle
- Media, title with supporting text
- Media, title with button
- Media, title, subtitle with supporting text

```swift
ODSCardView(element: ODSCardModel(title: "Title", description: "The description", image: Image("ods_empty"))
```

- Media, title, subtitle with button
- Media, title, subtitle with text button

_Soon available_

### Large cards (Title first)
_Soon available_

### Small cards
_Soon available_


