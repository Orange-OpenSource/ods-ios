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

There are a few ways cards can be presented. Ranging from a single title on its own for a simple card view or with more information shown in a subtitle and supporting text and actions at the bottom of the card.


### Large cards (Image first)

This is a full width card displayed with an image as first element.

This card is composed of two parts:
- Media: (today an image)
- Content: with a title, an optinal subtitle an optinal supporting text and optional buttons (zero up to two)

> **Implementation**

Card is configured using `ODSCardTitleFirstModel` like this:

```swift
let model = ODSCardImageFirstModel(
    title: "Title",
    subtitle: "Subtitle",
    image: Image("ods_empty", bundle: Bundle.ods),
    supportingText: "A supporting text to describe something")
    
ODSCardImageFirst(model: model) {
    ODSButton(text: "Button 1", emphasis: .highest) {
            // do something here
        }
    } buttonContent2: {
        ODSButton(text: "Button 1", emphasis: .highest) {
            // do something here
        } 
    }
}
```

### Large cards (Title first)

This is a full width card displaying with a title and a thumbnail on top as first element.

This card is composed of three parts:
- Header: with a title, an optinal subtitle and an optinal thmubnail
- Media: (today an image)
- Content: with an optinal supporting text and optional buttons (zero up to two)

> **Implementation**

Card is configured using `ODSCardTitleFirstModel` like this:

```swift
let model = ODSCardTitleFirstModel(
    title: "Title",
    subtitle: "Subtitle",
    thumbnail: Image("ods_empty", bundle: Bundle.ods),
    image: Image("ods_empty", bundle: Bundle.ods),
    supportingText: "A supporting text to describe something")
    
ODSCardTitleFirst(model: model) {
    ODSButton(text: "Button 1", emphasis: .highest) {
            // do something here
        }
    } buttonContent2: {
        ODSButton(text: "Button 1", emphasis: .highest) {
            // do something here
        } 
    }
}
```

### Small cards

The small card if prefered for two-column portrait mobile screen display.
As it is smaller than full-width cards, it contains only title and subtitle (optinal) in one line (Truncated tail).

> **Implementation**

Card is configured using `ODSSmallCardModel` like this:

```swift
let model = ODSCardTitleFirstModel(
    title: "Title",
    subtitle: "Subtitle",
    image: Image("ods_empty", bundle: Bundle.ods)) 

ODSSmallCard(model: model)
```

How to add Small Card in Grid 

```swift
let models = [
    ODSCardTitleFirstModel(
        title: "Title 1",
        subtitle: "Subtitle 1",
        image: Image("ods_empty", bundle: Bundle.ods)) { 
            Text("This card has a destination view")
        },
    ODSCardTitleFirstModel(
        title: "Title 2",
        subtitle: "Subtitle 2",
        image: Image("ods_empty", bundle: Bundle.ods)) { 
            Text("This card has a destination view")
        },
    //...
    ]

/// /!\ Don't forget to put the grid into a scrollview
ScrollView {
    LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
        ForEach(models) { model in
            ODSSmallCard(model: model)
        }
        .padding(.bottom, ODSSpacing.m)
    }
}
 
```

 


