---
layout: detail
title: Recirculation
description: Displays a list of applications can be downloaded and used by user.
---
---

**Page Summary**

* [Specifications references](#specifications-references)
* [Overview](#overview)
* [Implementation](#implementation)
* [Example about definiton of Apps Plus credentials](#example-about-definiton-of-apps-plus-credentials)

---

## Specifications references

- [Design System Manager - Modules - Recirculation](https://system.design.orange.com/0c1af118d/p/37aa79-recirculation)

## Overview

The _Recirculation module_ exposes a feature allowing the final users to get the available apps they can use.
This feature is based today only on the Orange proprietary _Apps Plus_ backend which provides a JSON file with list of apps and sections of apps.
This service today is based on a simple URL containing both a lang parameter and an API key. 

**This API key will define the type of data returned by the backend ; maybe you should have your own API key which matches the suitable filters to get only a subgroup of apps.**

## Implementation

To be able to call this service and display the list of available apps, you have to use the `ODSRecirculation`.
This _View_ has a `dataSource` parameter of type `ODSRecirculationDataSource` which must contain the type of source of data to display the apps:
                                     
```swift
    // Get data from the Apps Plus backend
    ODSRecirculation(dataSource: .remote(url: "https://url-to-appsplus-backend/get?apikey=SomeKey&lang=fr"))
    
    // Get data for some local files
    ODSRecirculation(dataSource: .local(path: somePathToJSONFileInResources))
```

Note also that the data picked from the _Apps Plus_ service is saved in cache directory so as to be used if the device is offline
or if an error occured.

If you want to flatten the list of apps without displaying categories, set the _flattenApps_ flag in the configuration:

```swift
    ODSRecirculation(dataSource: ..., flattenApps: true)
```  

The apps icons displayed in the list of apps can also be cached.
If you do not want to see these values put in cache, meaning e.g. displaying instead a placeholder if no network, use:

```swift
    ODSRecirculation(dataSource: ..., cacheAppsIcons: false)
```

The list of apps can trigger also haptic notifications, e.g. vibrations when the data have been lodaded or if an error occured.
By default this feature is enabled, but it can be disabled:

```swift
    ODSRecirculation(dataSource: ..., enableHaptics: false)
```

### Example about definiton of Apps Plus credentials

You can for example for your app use a _.xcconfig_ configuration settings file to store such credentials.
A key named **APPS_PLUS_URL** can be defined with the URL (containing the API key) to call.
Then the **Info.plist** file of your app must have an entry with the same name.
Of course the _.xcconfig_ file should not be versionned in Git, ensure this with [Gitleaks](https://github.com/gitleaks/gitleaks) for example.

See the example for the _.xcconfig_:

```text
// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974
// See also https://medium.com/swift-india/secure-secrets-in-ios-app-9f66085800b4

APPS_PLUS_API_KEY = SoMeApIkEy
APPS_PLUS_URL = https:/$()/url-to-api?apikey=$(APPS_PLUS_API_KEY)

// Here $() prevents the // to be interpreted as comment, we suppose the URL has an apikey parameter and is GET only
```

And the entry for the _Info.plist_:

```text
    <key>APPS_PLUS_URL</key> <!-- Key used in the demo app code -->
    <string>${APPS_PLUS_URL}</string> <!-- Key in the xcconfig side, or write here the full URL with API key but without lang -->
```

Then in your code you can read the URL, get the locale, and forge the final URL to give to `ODSMoreAppsItemConfig`.
We could have choosen this implemention deeper in the repository but wanted to let ODS lib users choose their own way to deal with the URL.

```swift
    private func buildAppsPlusURL() -> URL {
        guard let appsPlusURL = Bundle.main.infoDictionary?["APPS_PLUS_URL"] else {
            fatalError("No Apps Plus URL found in app settings")
        }
        let currentLocale = Bundle.main.preferredLocalizations[0]
        let requestURL = "\(appsPlusURL)&lang=\(currentLocale)"
        guard let feedURL = URL(string: requestURL) else {
            fatalError("Failed to forge the service URL to get more apps")
        }
        return feedURL
    }
    
    // And then ODSRecirculation(dataSource: .remote(url: buildAppsPlusURL()))
```

In some CI/CD chain, like our old-school Jenkins server with Groovy pipelines, we can use a _Fastlane_ lane to read some previously environment variable and
fill the _Info.Plist_ file in the suitable row.
