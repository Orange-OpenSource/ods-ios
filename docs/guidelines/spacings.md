---
layout: detail
title: Spacings
---
---

**Page Summary**

* [Specifications references](#specifications-references)
* [Usage](#usage)
  * [Apply spacing for magin](#apply-spacing-for-margin)
  * [Apply spacing for padding](#apply-spacing-for-padding)
  
---

## Specifications references

- [Design System Manager - Spacings](https://system.design.orange.com/0c1af118d/p/375be7-spacing)
- [Apple guideline - Layout](https://developer.apple.com/design/human-interface-guidelines/foundations/layout)

## Usage 

The spacing scale increases in small increments needed to describe both internal and external spacing relationships. Spacing tokens can be applied as padding and margins.

### Apply spacing for magin

Apply the spacing to get magin arround element like this:

``` swift
// Add a padding of 16px arround the text in the button

Button {
    // Add your action here
} label: {
    Text("ButtonText")
    .padding(.all, ODSSpacing.m)
}


// Add a magin of 16px (leading and trailing)
VStack {
    Text("Title")
    Text("A very long text for description in the main view")
}
.padding(.horizontal: ODSSpacing.m) // Add a margin to the

```

### Apply spacing for padding

Apply the spacing to separate elements like this:

``` swift
HStack(spacing: ODSSpacing.m) {
    Image(systemname: "heart")
    Text("Some text")
}
```
