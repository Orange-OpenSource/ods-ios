---
layout: detail
title: Text edit menu
description: Text selection with Orange branding
---


### Text selection

Text selection is available when text field or text editor is entering in edition mode. This is not a custom component but just a way to customize the component with coreOrange accent color.


#### Text selection example

```swift
    TextField("A text field", text: $textToEdit)
        .padding(.horizontal, 20)
        .font(ODSFontStyle.headline.font())
        .accentColor(ODSColor.coreOrange.color)
```
