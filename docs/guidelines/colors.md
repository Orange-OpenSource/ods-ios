---
layout: detail
title: Colors
---
---

**Page Summary**

* Table of contents
{:toc}

---

## Specifications references

- [Design System Manager - Colour](https://system.design.orange.com/0c1af118d/p/73fa17-colour/b/025652)
- [Apple guideline - The color system](https://developer.apple.com/design/human-interface-guidelines/foundations/color)

## Theme colors

Colors are defined in theme and described using `ODSColorDecription`, by setting :
- the asset name, 
- the bundle containing the asset 
- the color names for light and dark modes (used by demo application)

Colors will be different depending on whether they are displayed in light or in dark mode.

## How to use

### Using the color name

You can get color in theme using its name like this:

``` swift
 // Don't forget get theme from environment  
 @Environment(\.theme) var theme

 Image(systemName: "checkmark").foregroundColor(theme.color("coreOrange"))
 MyView().background(theme.color("functionalInfo"))
```

### Using components token

You can get color in theme using components token like this:

``` swift
// Don't forget get theme from environment
@Environment(\.theme) var theme

Button {
} label: {
    Text("Cancel")
    .padding(ODSSpacing.m)
}
.background(theme.componentColors.functionalNegative)
```
