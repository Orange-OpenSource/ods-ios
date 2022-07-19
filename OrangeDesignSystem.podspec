#
# Be sure to run `pod lib lint ods-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OrangeDesignSystem'
  s.version          = '0.4.1'
  s.summary          = 'Orange Design System Components'


# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Orange Design System Components.
                       DESC

  s.homepage         = 'https://github.com/Orange-OpenSource/ods-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Philippe Besombe' => 'philippe.besombe@orange.com', 'Patrick Boursier' => 'patrick.boursier@orange.com', 'Jean-Luc Chevalier' => 'jl.chevalier@orange.com', 'Julien Galhaut' => 'julien1.galhaut@orange.com', 'Guillaume Margé' => 'guillaume.marge@orange.com', 'Ludovic Pinel' => 'ludovic.pinel@orange.com' }
  s.source           = { :git => 'https://github.com/Orange-OpenSource/ods-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'

  s.source_files = 'OrangeDesignSystem/Sources/**/*.{m,swift}'
  
  s.resource_bundles = {
     'OrangeDesignSystem' => ['OrangeDesignSystem/Sources/Assets/**/*.{lproj, xcassets,json}']
  }
  
  s.resources = ["OrangeDesignSystem/Sources/Assets/**/*.{lproj,xcassets,json}"]

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftGen'
end
