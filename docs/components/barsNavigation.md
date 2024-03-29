---
layout: detail
title: Bars - navigation
description: Navigation bar with Orange branding
---

---

**Page Summary**

* Table of contents
{:toc}

---

## Specifications references

- [Design System Manager - Bars: navigation](https://system.design.orange.com/0c1af118d/p/34094d-bars-navigation/b/419eb1)
- [Apple guideline - Navigation bars](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/navigation-bars/)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Standard navigation bar

![Navigation bar standard light](images/bars_navigation_standard_light.png)
![Navigation bar standard dark](images/bars_navigation_standard_dark.png)

When using a navigation view, basic navigation is using 'inline' display mode by default. 

```swift
NavigationView {
    NavigationLink(destination: Text("destination")) {
        Text("Main view")
    }
    .navigationBarTitle("Standard", displayMode: .inline)
}

```

## Navigation bar with large title

![Navigation bar large light](images/bars_navigation_large_light.png)
![Navigation bar large dark](images/bars_navigation_large_dark.png)

Use 'large' display mode to enable large titles when scrolling up.

```swift
NavigationView {
    NavigationLink(destination: Text("destination")) {
        Text("Main view")
    }
    .navigationBarTitle("Standard", displayMode: .large)
}

```

## Navigation bar with search bar

![Navigation bar search light](images/bars_navigation_search_light.png)
![Navigation bar search dark](images/bars_navigation_search_dark.png)


Use .searchable modifier to add a search bar in the navigation view.

```swift
@State var searchQuery = ""
    
NavigationView {
    NavigationLink(destination: Text("destination")) {
        Text("Main view")
    }
    .navigationBarTitle("With search bar", displayMode: .inline)
    .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
}

```

## Navigation bar with action item

![Navigation bar items light](images/bars_navigation_items_light.png)
![Navigation bar items dark](images/bars_navigation_items_dark.png)

You can add one or several buttons (trailing or leading) in the navigation view by using .toolbar modifier

```swift
NavigationView {
    NavigationLink(destination: Text("destination")) {
        Text("Main view")
    }
    .navigationBarTitle("Standard", displayMode: .inline)
    .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                print("item action")
            } label: {
                Image(systemName: "ant.circle")
            }
        }
    }
}

```
