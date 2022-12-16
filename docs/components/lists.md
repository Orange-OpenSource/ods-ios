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
   * [Standard list item](#standard-list-item)
   * [Selection list item](#selection-list-item)

---

## Specifications references

- [Design System Manager - Lists](https://system.design.orange.com/0c1af118d/p/09a804-lists/b/669743)
- [Apple guideline - Lists and tables](https://developer.apple.com/design/human-interface-guidelines/components/layout-and-organization/lists-and-tables)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Variants
   
Here we just propose a configuration for two types of list items:
- Standard with trailing actions
- Selection with trailing icons (selection indicators) 
  
All items are composed of:
- Title
- Subtitle (optional)
- Leading icon (optional)

The leading icon is :
- icon or image from resources
- Image from url. During image loading a placeholder Image is needed. Three kinds of shape are proposed (circular, square or wide).
    
 
### Standard list item 
 
 For standard items, trailing icons can be added. Two types of icons are proposed:
    - with info button to make an action
    - with text (no action, only information)
    
The standard item can be used in a `NavigationLink` (for example, display more details)

```swift
// Create list items models

let itemsModels = [ 
                    ODSListStandardItemModel(title: "Title Only"),
                    ODSListStandardItemModel(title: "Title with subtitle", subtitle: "subtitle"),    
                    ODSListStandardItemModel(title: "Title with leading icon", leadingIcon: .icon(Image(systemName: "heart"))),
                    ODSListStandardItemModel(title: "Title with trailing action", ODSListItemTrailingActions(displayText: "Details")),
                ]

// Build the List view using ODSListStandardItemModel.
List {
    ForEach(itemModels, id: \.id) { itemModel in
        NavigationLink {
            Text("The destination view")
        } label: {
            ODSListStandardItem(model: itemModel)
        }
    }
}
```

### Selection list item

The selection list items can be used to enumerate data as list in order to select elements.

```swift
struct YourView: View {
    let models: [ODSListSelectionItemModel]

    init() {
        let iconImage = Image(systemName: "heart")
        models = [
            ODSListSelectionItemModel(
                title: "Title 1",
                subtitle: "Subtitle 1",
                leadingIcon: .icon(iconImage),
                trailingSelection: .checkmark),
            ODSListSelectionItemModel(
                title: "Title 2",
                subtitle: "Subtitle 2",
                trailingSelection: .checkmark)
        ]
    }

    var body: some View {
        List {
            ForEach(models, id: \.id) { model in
                ODSListSelectionItem(model: model)
            }
        }
    }
}     
```

**Note:** Don’t forget, if item is used in a `NavigationLink`, a chevron is automatically added by the system. For design purpose it is NOT recommended to add `ODSListSelectionItem` in a `NavigationLink`.

