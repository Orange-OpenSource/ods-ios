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
    * [Vertical Image First Card)](#vertical-image-first-card)
    * [Vertical Header First Card)](#vertical-header-first-card)
    * [Horizontal Card](#horizontal-card)
    * [Small Card](#small-card)
* [Component specific tokens](#component-specific-tokens)

---

## Specifications references

- [Design System Manager - Cards](https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

Images in cards are considered as decorative, so they are ignored by Voice Over.

## Variants

Cards are a contained and independent element that can display content and actions on a single topic.

There are a few ways cards can be presented. Ranging from a single title on its own for a simple card view or with more information shown in a subtitle and supporting text and actions at the bottom of the card.


### Vertical Image First Card

This is a full width card displayed with an image as first element.

This card is composed of two parts:
- Media: (today an image)
- Content: with a title, an optinal subtitle an optinal supporting text and optional buttons (zero up to two)

> **Implementation**

Card is configured using `ODSCardVerticalHeaderFirstModel` like this:

```swift
let model = ODSCardVerticalImageFirstModel(
    title: "Title",
    subtitle: "Subtitle",
    image: Image("ods_empty", bundle: Bundle.ods),
    supportingText: "A supporting text to describe something")
    
ODSCardVerticalImageFirst(model: model) {
    ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        }
    } buttonContent2: {
        ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        } 
    }
}
```

### Vertical Header First Card

This is a full width card displaying with a title and a thumbnail on top as first element.

This card is composed of three parts:
- Header: with a title, an optinal subtitle and an optinal thmubnail
- Media: (today an image)
- Content: with an optinal supporting text and optional buttons (zero up to two)

> **Implementation**

Card is configured using `ODSCardVerticalHeaderFirstModel` like this:

```swift
let model = ODSCardVerticalHeaderFirstModel(
    title: "Title",
    subtitle: "Subtitle",
    thumbnail: Image("ods_empty", bundle: Bundle.ods),
    image: Image("ods_empty", bundle: Bundle.ods),
    supportingText: "A supporting text to describe something")
    
ODSCardVerticalHeaderFirst(model: model) {
    ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        }
    } buttonContent2: {
        ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        } 
    }
}
```

### Horizontal Card

This is a full width card displaying with image on left and content with texts on the right. Additonal action buttons can be added at the bottom of the card. 

Thes content is composed by:
- a title
- an optional subtitle
- an optional supporting text for larger description

> **Implementation**

Card is configured using `ODSCardHorizontalModel` like this:

```swift
let model = ODSCardHorizontalModel(
    title: "Title",
    subtitle: "Subtitle",
    imageSource: .image(Image("ods_empty", bundle: Bundle.ods)),
    imagePosition: .leading,
    supportingText: "A supporting text to describe something")
    
ODSCardHorizontal(model: model) {
    ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        }
    } buttonContent2: {
        ODSButton(text: "Button 1", emphasis: .medium) {
            // do something here
        } 
    }
}
```

### Small Card  

The small card if prefered for two-column portrait mobile screen display.
As it is smaller than full-width cards, it contains only title and subtitle (optinal) in one line (Truncated tail).

> **Implementation**

Card is configured using `ODSCardSmallModel` like this:

```swift
let model = ODSCardSmallModel(
    title: "Title",
    subtitle: "Subtitle",
    image: Image("ods_empty", bundle: Bundle.ods)) 

ODSCardSmall(model: model)
```

How to add Small Card in Grid 

```swift
let models = [
    ODSCardSmallModel(
        title: "Title 1",
        subtitle: "Subtitle 1",
        image: Image("ods_empty", bundle: Bundle.ods)) { 
            Text("This card has a destination view")
        },
    ODSCardSmallModel(
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
            ODSCardSmall(model: model)
        }
        .padding(.bottom, ODSSpacing.m)
    }
}
 
```

 


