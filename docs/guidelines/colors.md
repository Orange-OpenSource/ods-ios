---
layout: detail
title: Colors
---
---

**Page Summary**

* [Specifications references](#specifications-references)
* [Implementation](#implementation)

---

## Specifications references

- [Design System Manager - Colour](https://system.design.orange.com/0c1af118d/p/73fa17-colour/b/025652)
- [Apple guideline - The color system](https://developer.apple.com/design/human-interface-guidelines/foundations/color)

## Implementation

Four categories of colors:
- Core
- Functional
- Supporting
- Not classified

Colors will be different depending on whether they are displayed in light or in dark mode.

You can use ODSColor like this:

``` swift
    Image(systemName: "checkmark").foregroundColor(ODSColor.coreOrange.color)
    MyView().background(ODSColor.primaryBackground.color)
```
