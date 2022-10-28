---
layout: detail
title: Typography
---
---

**Page Summary**

* [Specifications references](#specifications-references)
* [Implementation](#implementation)
  * [Apply font style on text](#apply-font-style-on-text)
  * [Apply font style on view](#apply-font-style-on-view)
  
---

## Specifications references

- [Design System Manager - Typography](https://system.design.orange.com/0c1af118d/p/54fe27-typography)
- [Apple guideline - Typography](https://developer.apple.com/design/human-interface-guidelines/foundations/typography/)

## Implementation 

ODS library defines its own font style. The font associated to the style is defined in the theme set in the environment.

### Apply font style on text

Apply the font style on text like this:

``` swift
 Text("Sample").odsFont(.title3)
 TextField("A text field", text: $textToEdit).odsFont(.title3)
```

### Apply font style on view

In the example below, the first text field has a font style set directly, while the font applied to the following container applies to all of the text views inside that container.
    
``` swift
VStack {
    Text("Font applied to a text view.")
        .odsFont(.largeTitle)

    VStack {
        Text("These two text views have the same font")
        Text("applied to their parent view.")
    }
    .odsFont(.title3)
}
```

