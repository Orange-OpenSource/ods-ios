#!/bin/bash
#
# Software Name: Orange Design System (iOS)
# SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
# SPDX-License-Identifier: MIT
#
# This software is distributed under the MIT license.
#

set -eu

# =======
# Metrics
# =======

NUMBER_OF_CHECKS=0
NUMBER_OF_SUCCESS=0
NUMBER_OF_WARNINGS=0
NUMBER_OF_ERRORS=0

# =====
# Utils
# =====

CheckIfFileExists(){
    if [ ! -f "$1" ]; then
        echo -e "\n⛔  ERROR: The file '$1' does not exist"
        NUMBER_OF_ERRORS=$((NUMBER_OF_ERRORS+1))
    else
        echo -e "\n✅  Cool! The file '$1' exists"
        NUMBER_OF_SUCCESS=$((NUMBER_OF_SUCCESS+1))
    fi
    NUMBER_OF_CHECKS=$((NUMBER_OF_CHECKS+1))
}

CheckIfRuntimeExists(){
    runtime_version=`$2`
    echo "$runtime_version"
    if [ $? != "0" ]; then # Exist status != 0 so runtime version check failed ; we assume the runtime is missing
        echo -e "\n❌  WARNING: It seems '$1' is not ready"
        NUMBER_OF_WARNINGS=$((NUMBER_OF_ERRORS+1))        
    else 
        echo -e "\n✅  Cool! '$1' is available"
        echo -e "\t🔎  You should check if the version is at least '$3'"
        NUMBER_OF_SUCCESS=$((NUMBER_OF_SUCCESS+1))
    fi
    NUMBER_OF_CHECKS=$((NUMBER_OF_CHECKS+1))
}

# ===========
# Doctor Who?
# ===========

read -p "✋ Are you ready to check preconditions to work on the project? [PRESS ANY KEY]"
echo -e "\n"

# ================
# Check n°1: Swift
# ================

read -p "✋ Let's check version of Swift (programming language)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "swift" "swift --version" "5.8"
echo -e "\n"

# ================
# Check n°2: Xcode
# ================

read -p "✋ Let's check version of Xcode (IDE)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "Xcode" "xcodebuild -version" "14.3"
echo -e "\n"

# ==================
# Check n°3: Bundler
# ==================

read -p "✋ Let's check version of Bundler (to install and use tools)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "Bundler" "bundle --version" "2.3.16"
echo -e "\n"

# ====================
# Check n°4: Cocoapods
# ====================

read -p "✋ Let's check version of CocoaPods (one of the dependency manager in use)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "CocoaPods" "pod --version" "1.13.0"
echo -e "\n"

# ===================
# Check n°5: Fastlane
# ===================

read -p "✋ Let's check version of Fastlane (for automation)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "Fastlane" "fastlane --version" "2.216.0"
echo -e "\n"

# ====================
# Check n°6: SwiftLint
# ====================

read -p "✋ Let's check version of SwiftLint (the linter for the sources)..."
echo -e "\n"
CheckIfRuntimeExists "SwiftLint" "swiftlint --version" "0.52.4"
echo -e "\n"

# ======================
# Check n°7: SwiftFormat
# ======================

read -p "✋ Let's check version of SwiftFormat (for headers and code style)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "SwiftFormat" "swiftformat --version" "0.52.4"
echo -e "\n"

# ====================
# Check n°8: Periphery
# ====================

read -p "✋ Let's check version of Periphery (for dead code hunt)... [PRESS ANY KEY]"
echo -e "\n"
CheckIfRuntimeExists "Periphery" "periphery version" "2.15.0"
echo -e "\n"

# =============================
# Check n°9: Dependencies files
# =============================

read -p "✋ Let's check some dependencies manager files you have to have... [PRESS ANY KEY]"
echo -e "\n"
CheckIfFileExists "./Gemfile"
CheckIfFileExists "./Gemfile.lock"
CheckIfFileExists "./Package.swift"
CheckIfFileExists "./Package.resolved"
CheckIfFileExists "./OrangeDesignSystemDemo/Podfile"
CheckIfFileExists "./OrangeDesignSystemDemo/Podfile.lock"
echo -e "\n"

# =================
# Check n°10: Tests
# =================

read -p "✋ Let's launch the test, they must all pass... [PRESS ANY KEY]"
echo -e "\n"
cd OrangeDesignSystemDemo/
bundle exec fastlane test
cd ..
echo -e "\n"

# ==========
# Conclusion
# ==========

read -p "✋ Preconditions checks are done! [PRESS ANY KEY]"
echo -e "\tNumber of controls.......: $NUMBER_OF_CHECKS"
echo -e "\tNumber of success........: $NUMBER_OF_SUCCESS"
echo -e "\tNumber of warnings.......: $NUMBER_OF_WARNINGS"
echo -e "\tNumber of errors.........: $NUMBER_OF_ERRORS"