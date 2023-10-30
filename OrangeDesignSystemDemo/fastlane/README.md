fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

RUN TESTS BY TRIGGERING THE TESTS PLANS OF THE PROJECT

### ios increment

```sh
[bundle exec] fastlane ios increment
```

UPDATE BUILD NUMBER WITH TIMESTAMP

### ios prepare_release

```sh
[bundle exec] fastlane ios prepare_release
```

READ AND SET NEXT RELEASE NOTE IN CHANLOG

### ios buildDebugApp

```sh
[bundle exec] fastlane ios buildDebugApp
```

BUILD DEBUG APP

### ios qualif

```sh
[bundle exec] fastlane ios qualif
```

BUILD & UPLOAD TO TESTFLIGHT QUALIF APP

### ios prod

```sh
[bundle exec] fastlane ios prod
```

BUILD & UPLOAD TO TESTFLIGHT (if set in options: upload) PROD APP

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
