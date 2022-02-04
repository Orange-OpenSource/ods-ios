---
layout: detail
title: Standard button
description: A standard button is based on ODSGenericButtonContent
---


### Icon add button

Icon add button is based on `ODSGenericButtonContent` with `plus.circle` apple system icon

```swift
let imageDescription = ODSImageDescription(image: 
    Image(systemName: "plus.circle").renderingMode(.template),
        imageWidth: 30,
        imageHeight: 30,
        foregroundColor: ODSColor.coreOrange.color)

Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription)
}
``` 

### Icon info button

Icon Info button is identical to Icon add button with `info.circle` apple system icon 

```swift
let imageDescription = ODSImageDescription(image: 
    Image(systemName: "info.circle").renderingMode(.template),
        imageWidth: 30,
        imageHeight: 30,
        foregroundColor: ODSColor.coreOrange.color)

Button {
    // button action
} label: {
    ODSGenericButtonContent(imageDescription: imageDescription)
}
``` 

### Label button

Label button is a simple label button with Orange theme. It is based on `ODSGenericButtonContent` with a top text

```swift
Button {
    // button action
} label: {
    ODSGenericButtonContent(topText: "Button label", textColor: ODSColor.coreOrange.color)
}
``` 
