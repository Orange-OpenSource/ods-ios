---
layout: detail
title: Lists
description: Lists are continuous, vertical indexes of text or images.
---

---

**Page Summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
   * [Standard list item with title](#standard-list-item-with-title)
   * [List item with title and toggle](#interaction-and-animation)
* [Interaction and animation](#interaction-and-animation)
    *  [Selection](#selection)
    *  [Interaction](#interaction)

---

## Specifications references

- [Design System Manager - Lists](https://system.design.orange.com/0c1af118d/p/09a804-lists/b/669743)
- [Apple guideline - Lists and tables](https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/lists-and-tables)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants

The native List behaviour is prefered. Here we just propose a configuration for two types of list items:
- Standard with title, subtitle, left image, right icon
- Title with toggle 

Those items can olso define a minimum height (`ODSListItemMinHeight`):
- medium
- large


### Standard list item with title
 
It is composed with:
- Title only
- Subtitle (optional)
- Leading Icon (optional)
- Trailing Icon (optional)
    - with info button (action)
    - with text (no action, only information)
    
The leading icon is :
- Image from resources
- Image from url. During image loading a placeholder Image is needed  
    
```swift
// Create list items models
let image = Image(systemName: "heart")
let leadingIconModel = ODSListItemLeadingIconModel.withImage(image)
let trailingIconModel = ODSListItemTrailingIconModel.text("Details")

let itemsModels = [ 
                    ODSListItemModel(title: "Title Only"),
                    ODSListItemModel(title: "Title with subtitle", subtitle: "subtitle"),    
                    ODSListItemModel(title: "Title with leadingImage", leadingIconModel: leadingIconModel),
                    ODSListItemModel(title: "Title with trailingIcon", trailingIconModel: trailingIconModel),
                ]

// Build the List view using ODSListItem with model
List {
    ForEach(itemModels, id: \.id) { itemModel in
        NavigationLink {
            Text("The destination view")
        } label: {
            ODSListItem(model: itemModel)
        }
    }
}
```

### List item with title and toggle

**Note:** Don’t forget, if item is set in a NavigationLink, a chevron is automatically added on right by the system. For design purpose it is NOT recommended to add ODSListItemWithToggle in a NavigationLink.

```swift      
@State var isOn: Bool = false
        
let itemModel = [ODSListItemWithToggleModel(title: "Title: cell with toggle", isOn: $isOn)]
        
    List {
        ForEach(itemModels, id: \.id) { itemModel in
            ODSListItemWithToggle(model: itemModel)
        }
    }
```


## Selection and Interaction animations

### Selection

Signle or multiple selection are handled by the system natively. 
So, animations for selection follow the standard iOS guidelines.

### Interaction

Don't forget, if item is set in a `NavigationLink`, a chevron is automatically added on right by the system.
For design purpose it is NOT recomanded to add `ODSListItemWithToggle` in a `NavigationLink`.

In other case, animation for control follows the standard iOS guidelines.

