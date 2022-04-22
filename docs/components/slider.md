---
layout: detail
title: Standard button
description: A standard button is based on ODSGenericButtonContent
---


### Slider

Slider is a normal Slider component with accent color set to coreOrange.


#### Unlabeled slider

```swift
Slider(value: $value, in: 0 ... 100)
```

#### Labeled slider (with images)

```swift
HStack {
    Image(systemName: "speaker.wave.1.fill")
    Slider(
        value: $value,
        in: 0 ... 100,
        step: 5)
        .accentColor(ODSColor.coreOrange.color)
    Image(systemName: "speaker.wave.3.fill")
}
``` 

