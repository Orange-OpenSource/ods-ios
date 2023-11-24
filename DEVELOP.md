# Developer guide

## Check preconditions

You can check wether or not you have the tools in use in the project like _Fastlane_, _SwiftLint_, _SwiftFormat_, etc.
To check these preconditions, run the command bellow and check its results.

```bash
./doctor.sh
```

## Build OrangeDesignSystemDemo

To build the demo application follow those steps.

1. `cd OrangeDesignSystemDemo`
2. `bundle exec pod install`
3. Open *OrangeDesignSystemDemo/OrangeDesignSystemDemo.xcworkspace*
4. Select *OrangeDesignSystemDemo* scheme
5. Build and run the Application on your device ou simulator

## Documentation

Execute the commands below to generate and run the documentation:

1. `cd docs`
2. `bundle install`
3. `bundle exec jekyll serve --trace --watch --force_polling --livereload --livereload-port 4001`

If you encounter errors during installation and your platform is not listed in the `PLATFORMS` section of `Gemfile.lock`, you can optionally run `bundle platform` to retrieve your platform, then `bundle lock --add-platform <your_platform>` to install specific dependencies for your platform.

Finally, open your browser and go to http://127.0.0.1:4000/ods-ios/

## Build phases

The project contains several custom build phases so as to automatize several steps:

1. _SwiftFormat (headers of sources)_ format the source code files headers with a template
2. _SwiftLint_ will run the linter on the sources
3. _Check JSON files format_ will run a Shell command to check wether or not the AppNews JSON files are compliant JSON files or not

## Targets

The Xcode project contains three targets:

1. _OrangeDesignSystemDemo_ for the application
2. _OoangeDesignSystemDemoTests_ for the unit tests targeting the library
3. _Periphery (dead code finder)_ to look for dead code in the source code

## JSON file validations

Some JSON files are used in the application like the _AppNews.json_.
You can check its integrity and if all the fields are well defined by using its JSON schema:

```json
// Can be stored in a schema.json file for further tests
{
    "$schema": "https://json-schema.org/draft/2020-12/schema",
    "$id": "https://github.com/Orange-OpenSource/ods-ios/schema/AppNews",
    "title": "App News",
    "description": "The catalog of app news with date, versions and news",
    "items": {
        "type": "object",
        "properties": {
            "version": {
                "description": "The version of the app with these news, matching the releases",
                "type": "string"
            },
            "date": {
                "description": "The date in yyyy-MM-dd format",
                "type": "string"
            },
            "news": {
                "description": "The main news of the app",
                "type": "string"
            }
        }
    },
  "required": [ "version", "date", "news" ]
}
```

Then you can run the following command bellow to check if the _AppNews.json_ file matches the specification of the schema:

```shell
check-jsonschema --schemafile schema.json AppNews.json
```
