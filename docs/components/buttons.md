---
layout: detail
title: Buttons
description: A button allows a user to perform an action or to navigate to another page. It contains a text label and a supporting icon can be displayed.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
    * [Emphasis button](#emphasis-button)
    * [Functional button](#functional-button)
    * [Icon button](#icon-button)

---

## Specifications references

- [Design System Manager - Buttons](https://system.design.orange.com/0c1af118d/p/278734-buttons-shape/b/536b5f)
- [Apple guideline - Buttons](https://developer.apple.com/design/human-interface-guidelines/components/menus-and-actions/buttons)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

### Emphasis button

Button variants range in style to denote emphasis. Use different styles and not size to show the preferred choice. 

- **Layout**

**Large**

![Buttons high emphasis disabled](images/buttons_layout_large_with_icon.png)

![Buttons high emphasis](images/buttons_layout_large_without_icon.png)

**Small**

![Buttons high emphasis disabled](images/buttons_layout_small_with_icon.png)

![Buttons high emphasis](images/buttons_layout_small_without_icon.png)

 
- **Emphasis**

**High emphasis**

![Buttons high emphasis disabled](images/buttons_functionnal_disabled.png)
![Buttons high emphasis](images/buttons_emphasis_high.png)

**Medium**

![Buttons medium emphasis disabled](images/buttons_functionnal_disabled.png)
![Buttons medium emphasis](images/buttons_emphasis_medium.png)

**Low emphasis**

![Buttons low emphasis disabled](images/buttons_functionnal_disabled.png)
![Buttons low emphasis](images/buttons_emphasis_low.png)

**Lowest emphasis**

![Buttons lowest emphasis disabled](images/buttons_emphasis_lowest_disabled.png)
![Buttons lowest emphasis](images/buttons_emphasis_lowest.png)

- **Implementation**
 
```swift
// High emphasis
ODSButton(text: Text("Some text"),
          image: Image("Add"),
          emphasis: .high) {}

// Lowest emphasis
ODSButton(text: Text("Some text"),
          image: Image("Add"),
          emphasis: .lowest) {}
``` 

### Functional button

If required, colour versions can also be used to inform users of positive or negative destructive actions.

**Positive**

![Buttons functional positive disabled](images/buttons_functionnal_disabled.png) 
![Buttons functional positive](images/buttons_functional_positive.png)

**Negative**

![Buttons functional negative disabled](images/buttons_functionnal_disabled.png)
![Buttons functional negative](images/buttons_functional_negative.png)

```swift
    // Negative button
    ODSFunctionalButton(text: Text("Some text"), style: .negative) 
    { /* action: Do something */ }
    
    ODSFunctionalButton(text: Text("Some text"), image: Image("Add"), style: .negative)
    { /* action: Do something */ }
    
    // Positive button
    ODSFunctionalButton(text: Text("Some text") style: .positive)
    { /* action: Do something */ }
    
    ODSFunctionalButton(text: Text("Some text"), image: Image("Add"), style: .positive)
    { /* action: Do something */ }
    
    // To disable the button
    ODSFunctionalButton(text: Text("Some text"), style: .positive) { /* action: Do something */ }
    .disabled(true)
```

### Icon button

Plain buttons are the most ubiquitous component found throughout applications. Consisting an icon, they are the most simple button style.

![Buttons icon](images/buttons_icon.png)

```swift
// icon with system asset
ODSIconButton(image: Image(systemName: "info.circle")) {}

// icon with Solaris asset
ODSIconButton(image: Image("Add")) {}
```



