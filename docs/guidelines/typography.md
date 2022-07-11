---
layout: detail
title: Typography
description: How to use ODS Typography
---
---

**Page Summary**

* [Specifications references](#specifications-references)
* [Implementation](#implementation)
  * [TextStyles](#textstyles)

---

## Specifications references

- [Design System Manager - Typography](https://system.design.orange.com/0c1af118d/p/54fe27-typography)
- [Apple guideline - The type system](https://developer.apple.com/design/human-interface-guidelines/foundations/typography/)

## Implementation 

### Style on Text

ODS library uses the Apple type system.
Retrieve the TextStyles like so:

``` swift
 
 Text("Sample").odsFont(.title3)
 TextField("A text field", text: $textToEdit).odsFont(.title3)

```

### Style on View
Sets the default font for text in the view.

In the example below, the first text field has a font set directly, while the font 
applied to the following container applies to all of the text views inside that container:
    
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

