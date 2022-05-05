---
layout: detail
title: Edit text
description: A system behavior fior text fields branded for Orange
---


### Edit text

Edit text is available when text field or text editor  is entering in edition mode. This is not a custom component but just a way to customize the component with coreOrange accent color.


#### Edit text example

```swift
    TextField("A text field", text: $textToEdit)
        .padding(.horizontal, 20)
        .font(ODSFontStyle.headline.font())
        .accentColor(ODSColor.coreOrange.color)
```
