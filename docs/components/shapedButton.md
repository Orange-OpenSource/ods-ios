---
layout: detail
title: Shaped button
description: A shaped button is based on `ODSGenericButtonContent` by applying predefined button style
---

```swift
let imageDescription = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"),
    imageWidth: 30, 
    imageHeight: 30, 
    foregroundColor: ODSColor.core_black_900.color)
```

### Filled shaped button

Filled shaped button is based on `ODSGenericButtonContent` with button style `ODSFilledButtonStyle`

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Title", bottomText: "Subtitle", textColor: ODSColor.core_black_900.color)
}
.buttonStyle(ODSFilledButtonStyle())
``` 

### Shaped button with border

Shaped button with border is based on `ODSGenericButtonContent` with button style `ODSBorderedButtonStyle`

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Title", bottomText: "Subtitle", textColor: ODSColor.core_black_900.color)
}
.buttonStyle(ODSBorderedButtonStyle())
``` 

