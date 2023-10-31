#
# Software Name: Orange Design System (iOS)
# SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
# SPDX-License-Identifier: MIT
#
# This software is distributed under the MIT license.
#

source "https://rubygems.org"

gem "fastlane",  '~>2.211.0'
gem "cocoapods",  '1.13.0'

# See https://stackoverflow.com/questions/77236339/after-updating-cocoapods-to-1-13-0-it-throws-error
gem 'activesupport', '~> 7.0.8'

plugins_path = File.join(File.dirname(__FILE__), 'OrangeDesignSystemDemo/fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
