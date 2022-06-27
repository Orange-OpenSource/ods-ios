---
layout: detail
title: Sliders
description: A standard slider branded for Orange
---


### Slider

Slider is a normal Slider component with accent color set to coreOrange.


#### Unlabeled slider

```swift
Slider(value: $value, in: 0 ... 100)
    .accentColor(ODSColor.coreOrange.color)
```

#### Labeled slider (with images)

```swift
Slider(
    value: $value,
    in: 0 ... 100) {
        Text("Value")
} minimumValueLabel: {
    Image(systemName: "speaker.wave.1.fill")
} maximumValueLabel: {
    Image(systemName: "speaker.wave.3.fill")
}.accentColor(ODSColor.coreOrange.color)
``` 

#### Labeled slider (with text)

```swift
Slider(
    value: $value,
    in: 0 ... 100) {
        Text("Value")
} minimumValueLabel: {
    Text("  0")
} maximumValueLabel: {
    Text("100")
}.accentColor(ODSColor.coreOrange.color)
``` 

#### Stepped slider (with text and value display)

```swift
Text("Stepped slider").odsFont(style: .title2)
Text("Value : \(Int(value))").odsFont(style: .bodyRegular)
VStack(alignment: .center) {
    Slider(
        value: $value,
        in: 0 ... 100,
        step: 10) {
            Text("Value")
    } minimumValueLabel: {
        Text("  0")
    } maximumValueLabel: {
        Text("100")
    }
}.padding([.leading, .trailing], 10)
``` 
