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
    * [Progress bar](#progress-bar)
    * [Activity indicator](#activity-indicator)

---

## Specifications references

- [Design System Manager - Progress indicators](https://system.design.orange.com/0c1af118d/p/5969ab-progress-indicator)
- [Apple guideline - Progress indicators](https://developer.apple.com/design/human-interface-guidelines/components/status/progress-indicators)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

Progress indicators show users that elements or pages are loading.

### Progress bars

Progres bar is used to display **determinate** operations. It display the indicator increasing in width from 0 to 100% of the track, in sync with the process’s progress. 

To display the indicator as progress bar with a specific color use the `tint`.

We recommend to use the theme for that using the accent color as shown in following exemple.  
 
```swift
ProgressView("Downloading...", value: value, total: 100)
    .tint(theme.componentColors.accent)
```

It is possible to display the current value to provide more context.

```swift
ProgressView(value: value, total: 100) {
    Text("Downloading...")
} currentValueLabel: {
    let percent = String(format: "%0.2f", value)
    Text("\(percent) %").frame(maxWidth: .infinity, alignment: .trailing)
}
.tint(theme.componentColors.accent)
```

### Activity indicators

Activity indicator is used to display **Indeterminate** operations. It spins while a task is performed. 

```swift
ProgressView()
``` 

An additional label can be added to provide more context.

```swift
ProgressView {
   Text("Loading...")
}
```
