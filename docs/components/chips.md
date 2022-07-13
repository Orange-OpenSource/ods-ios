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
  * [Multiple selection](#multiple-selection)

---

## Specifications references

- [Design System Manager](https://zeroheight.com/3b9fee398/v/latest/p/67a9e8-chips/b/604d19)

## Accessibility

Please follow [accessibility criteria for development](https://a11y-guidelines.orange.com/en/mobile/ios/)

Chips support content labeling for accessibility and are readable by most screen readers, such as
TalkBack. Text rendered in chips is automatically provided to accessibility services. Additional
content labels are usually unnecessary.

## Variants

According to the `ODSChip` configuration following representations are available.

```swift
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

The option allows a single chip selection from a set of options. Depending  on `allowZeroSelection` parameter, it is possible to accept at least one or zero selected chip.

```swift
    struct ODSChipPickerSingleSelection: View {
        @State var singleSelection: Int?

        var body: some View {
            ODSChipPicker(title: "Single selection",
                          selection: $singleSelection,
                          allowZeroSelection: true,
                          chips: [ODSChip(.title1, text: "Chips 1"), ODSChip(.title2, text: "Chip 2")]
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
                          chips: [ODSChip(.title1, text: "Chips 1"), ODSChip(.title2, text: "Chip 2")]
            )
        }
    }
```
