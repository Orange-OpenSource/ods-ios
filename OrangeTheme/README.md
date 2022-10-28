# OrangeTheme

This library defines the theme for Orange branded applications. 

The colors of the brand are specified and some of theme are used for graphics elements and components:

- application global tint color 
- navigation bar (tint, background and title)
- tab bar (items, selected item, and background)
- components: buttons, sliders, progress indicators...

The theme also defines the spacings and fonts for specified styles.

# How to use it

Instanciate in you code (application) the `OrangeThemeFactory`and get the associated theme.

Then add this `OrangeTheme` in the environment.

```swift
@main
struct YourApplication: App {
    
    let themeFactory = OrangeThemeFactory()
            
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(themeFactory.theme.componentColors.accent)
                .environment(\.theme, themeFactory.theme)
        }
    }
}
```

If your application uses navigation bar and/or tab bar you can use the `ODSThemeableView` directly like this:

```swift
@main
struct YourApplication: App {
    
    var body: some Scene {
        WindowGroup {
            ODSThemeableView(theme: OrangeThemeFactory().theme) {
                ContentView()
            }
        }
    }
}
```


  
