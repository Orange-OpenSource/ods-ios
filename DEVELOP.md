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
