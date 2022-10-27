---
layout: detail
title: Progress indicator
description: Progress indicators show users that elements or pages are loading
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [Labeled progress bar](#labeled-progress-bar)
    * [Unlabeled activity indicator](#unlabeled-activity-indicator)

---

## Specifications references

- [Design System Manager - Progress indicators](https://system.design.orange.com/0c1af118d/p/5969ab-progress-indicator)
- [Apple guideline - Progress indicators](https://developer.apple.com/design/human-interface-guidelines/components/status/progress-indicators)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

Progress indicators show users that elements or pages are loading.

### Labeled progress bar

To display the indicator as progress bar with the a specific color use the `tint`.
We recommend to use the theme for that using the accent color as shown in following exemple.  
 
```swift
ProgressView("Downloading…", value: $value, total: 100)
    .tint(theme.componentColors.accent)
```

### Unlabeled progress indicator
```swift
ProgressView()
``` 
