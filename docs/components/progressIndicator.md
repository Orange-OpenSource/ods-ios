---
layout: detail
title: Progress indicator
description: Progress indicators show users that elements or pages are loading
---


### Progress indicator

Progress indicators show users that elements or pages are loading.


#### Labeled progress bar

```swift
ProgressView("Downloading…", value: $value, total: 100)
    .accentColor(ODSColor.coreOrange.color)
```

#### Unlabeled progress indicator
```swift
ProgressView()
    .accentColor(ODSColor.coreOrange.color)
``` 
