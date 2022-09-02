---
layout: detail
title: Chips
description: Chips are compact elements that represent an input, attribute, or action.
---

---

**Page summary**

* [Specifications references](#specifications-references)
* [Accessibility](#accessibility)
* [Variants](#variants)
* [Choice selection](#choice-selection)
  * [Single election](#single-selection)
    * [Single selection, One chip selected](#single-selection-one-chip-selected)
    * [Single selection, No chip selected](#single-selection-no-chip-selected)
  * [Multiple selection](#multiple-selection)

---

## Specifications references

- [Design System Manager](https://system.design.orange.com/0c1af118d/p/85a52b-components/b/1497a4)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

Chips support dynamic types for accessibility. 

## Variants

According to the `ODSChip` configuration following representations are available.

```swift
    enum MyChip: Int {
        case enabled
        case selected
        case disabled
    }

    // Text only
    ODSChip(.enabled, text: "Enable")
    
    // Text with icon
    ODSChip(.enabled, text: "Enable", thumbnail: .icon(iconImage))
            
    // Text with system icon
    ODSChip(.enabled, text: "Enable", thumbnail: .iconSystem(name: "heart"))
            
    // Text with avatar
    ODSChip(.enabled, text: "Enable", thumbnail: .avatar(avatarImage))
```

A chip can also be disabled, and removable from the list of selection

``` swift    
    // Removable
    ODSChip(.enabled, text: "Enable", removable: true)

    // Disbaled
    ODSChip(.enabled, text: "Enable", disbaled: true)

```


## Choice selection

The selection is managed by the `ODSChipPicker` providing the right type of selection. 

### Single selection

The option allows a single chip selection from a set of options. According to the type of selection (optinal or not), it is possible to accept at least one or zero selected chip.

#### Single selection, One chip selected

```swift
    enum ChipTest Int{  
        case title1 = 1,
        case title2 = 2
    }

    struct ODSChipPickerSingleSelection: View {
        @State var singleSelection: ChipTest
        let chips = [ODSChip<ChipTest>]

        var body: some View {
            ODSChipPicker(title: "Single selection (at least one element)",
                          selection: $singleSelection,
                          chips: chips)
            )
        }
        
        init() {
            chips = [ODSChip(.title1, text: "Chips 1"), ODSChip(.title2, text: "Chip 2")]
            singleSelection = .title1
        }
    }
```

#### Single selection, No chip selected

```swift
    struct ODSChipPickerSingleSelection: View {
        @State var singleSelection: ChipTest?

        var body: some View {
            ODSChipPicker(title: "Single selection (No chip seleted allowed)",
                          selection: $singleSelection,
                          chips: chips]
            )
        }
    }
```
    
### Multiple selection

The option allows a multiple chips selection from a set of options. Depending  on `allowZeroSelection` parameter, it is possible to accept at least one or zero selected chip.

```swift
    struct ODSChipPickerMultipleSelection: View {
        @State var multipleSelection: [Int]

        var body: some View {
            ODSChipPicker(title: "Multiple selection",
                          selection: $multipleSelection,
                          allowZeroSelection: true,
                          chips: chips]
            )
        }
    }
```
