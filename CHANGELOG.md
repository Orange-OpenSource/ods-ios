# ODS library changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/Orange-OpenSource/ods-ios/compare/1.1.0...qualif)

## [1.1.0](https://github.com/Orange-OpenSource/ods-ios/compare/1.0.0...1.1.0) - 2024-03-08

### Changed

- [DemoApp/SDK] Small fixes in the release documentation
- [DemoApp] Add accessibility statement in online resources and point to it from app ([#786](https://github.com/Orange-OpenSource/ods-ios/issues/786)) 

## [1.0.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.17.0...1.0.0) - 2024-03-06

### Added

- [DemoApp] List of third-party librairies integrated in the app ([#778](https://github.com/Orange-OpenSource/ods-ios/issues/778))
- [SDK/DemoApp] Display accessibility conformity status instead of simple title wording for accessibility statement menu entry ([#772](https://github.com/Orange-OpenSource/ods-ios/issues/772))
- [SDK/DemoApp] Create Recirculation module and update About module to use it ([#684](https://github.com/Orange-OpenSource/ods-ios/issues/684))
- [Tooling/DemoApp] Display build tag in about screen for beta releases (TestFlight)
- [SDK/DemoApp] Add ODSEmptyState module ([#558](https://github.com/Orange-OpenSource/ods-ios/issues/558))
- [Tooling] Add Git tags in CI/CD pipelines for TestFlight builds, update CocoaPods ([#680](https://github.com/Orange-OpenSource/ods-ios/issues/680))

### Fixed

- [SDK] Update the tab bar configuration to see the separator ([#712](https://github.com/Orange-OpenSource/ods-ios/issues/712))
- [SDK/DemoApp] Disable vocalization of text on image in cards component ([#702](https://github.com/Orange-OpenSource/ods-ios/issues/702))
- [DemoApp] Set focus on first item in Modules page ([#719](https://github.com/Orange-OpenSource/ods-ios/issues/719))
- [DemoApp] Update padding in components screen when cards are in one column ([#654](https://github.com/Orange-OpenSource/ods-ios/issues/654))
- [DemoApp] Fix accessibility issues on the demo screen of Bars-navigation component ([#574](https://github.com/Orange-OpenSource/ods-ios/issues/574))
- [SDK] Change the order of the accessibility focus between header and content in bottom sheet ([#703](https://github.com/Orange-OpenSource/ods-ios/issues/703))
- [SDK] Fix expanding Bottom Sheet on iPad ([#428](https://github.com/Orange-OpenSource/ods-ios/issues/428))
- [DemoApp] Spacer indicator missing on spacing guidelines page ([#707](https://github.com/Orange-OpenSource/ods-ios/issues/707))
- [DemoApp] On "Customize" bottom sheets, the hint is reversed ([#704](https://github.com/Orange-OpenSource/ods-ios/issues/704))
- [SDK] Vocalized buttons selected status with Voice Over ([#583](https://github.com/Orange-OpenSource/ods-ios/issues/583))
- [DemoApp/SDK] Customize accordion status is not vocalized ([#581](https://github.com/Orange-OpenSource/ods-ios/issues/581))

### Changed

- [DemoApp] Update illustrations for empty state module (Innocation Cup theme), update assets loading logic ([#776](https://github.com/Orange-OpenSource/ods-ios/issues/776)) 
- [SDK] Update accessibility statement library to v1.2.0
- [Tooling] Update dependency SwiftFormat/CLI to v0.53.3
- [Tooling] Refactor CI/CD lanes
- [SDK/DemoApp] Update assets for empty state and recirculation modules ([#692](https://github.com/Orange-OpenSource/ods-ios/issues/692))
- [SDK] Group labels and associated elements in ChipsPickers ([#677](https://github.com/Orange-OpenSource/ods-ios/issues/677))
- [SDK] Group Labels in ODSListItems for accessibility ([#741](https://github.com/Orange-OpenSource/ods-ios/issues/741))
- [DemoApp] Update AppIcons changed during runner migration ([#738](https://github.com/Orange-OpenSource/ods-ios/issues/738))
- [Tooling] Update dependency SwiftFormat/CLI to v0.53.2 
- [SDK/DemoApp] Update ListItemm to add AppIcon for leading element ([#716](https://github.com/Orange-OpenSource/ods-ios/issues/716))
- [SDK] Use appIcons in recirculation module ([#698](https://github.com/Orange-OpenSource/ods-ios/issues/698))
- [Tooling] Migration to GitLab CI runner ([#727](https://github.com/Orange-OpenSource/ods-ios/issues/727))
- [DemoApp] Update the demo configuration for recirculation module ([#714](https://github.com/Orange-OpenSource/ods-ios/issues/714))
- [SDK] Update background color of the navigation and tab bars for accessibility reason ([#693](https://github.com/Orange-OpenSource/ods-ios/issues/693))
- [DemoApp] Fix wrong color of the close button ([#412](https://github.com/Orange-OpenSource/ods-ios/issues/412))
- [SDK] About module, Add error views for more apps and appnews ([#689](https://github.com/Orange-OpenSource/ods-ios/issues/689))

## [0.17.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.16.0...0.17.0) - 2024-02-07

- [DemoApp] Remove french wordings because not enough ready yet ([#663](https://github.com/Orange-OpenSource/ods-ios/issues/663))
- [Tooling] Various updates ([#667](https://github.com/Orange-OpenSource/ods-ios/issues/667))
- [DemoApp] Remove duplicate files preventing build to be done
- [DemoApp] Add pull to refresh on Cards and Banners screens ([#655](https://github.com/Orange-OpenSource/ods-ios/issues/655))
- [SDK] ODSButton with low emphasis has incorrect background color (Bug [#578](https://github.com/Orange-OpenSource/ods-ios/issues/578))
- [DemoApp/SDK] Focus order not coherent with Voice Over (Bug [#588](https://github.com/Orange-OpenSource/ods-ios/issues/588))
- [DemoApp] Add configuration in the ListItem screeen to select the number of lines in subtitle([#650](https://github.com/Orange-OpenSource/ods-ios/issues/650))
- [SDK] Update ListItem to limit title in one line and subtitle up to two lines ([#586](https://github.com/Orange-OpenSource/ods-ios/issues/586))
- [DemoApp/SDK] Components page accessibility issues (Bug [#563](https://github.com/Orange-OpenSource/ods-ios/issues/563))
- [DemoApp/SDK] Code cleanup ([#647](https://github.com/Orange-OpenSource/ods-ios/issues/647)])
- [SDK] Update Banners to align buttons when text is too long ([#642](https://github.com/Orange-OpenSource/ods-ios/issues/642))
- [SDK] Update Cards to align buttons when text is too long ([#630](https://github.com/Orange-OpenSource/ods-ios/issues/630))
- [Tooling] Upgrate to xcode 15 ([#638](https://github.com/Orange-OpenSource/ods-ios/issues/638))
- [DemoApp/SDK] ODSSmallCard and GridOfSmallCards a11y issue if accessible text sizes in use ([#598](https://github.com/Orange-OpenSource/ods-ios/issues/598))
- [Tooling] Upgrade to Xcode 15 ([#638](https://github.com/Orange-OpenSource/ods-ios/issues/638))
- [Tooling] Upgrade tools versions and internal librairies ([#639](https://github.com/Orange-OpenSource/ods-ios/issues/639))
- [Docs] Update documentation with illustration ([#602](https://github.com/Orange-OpenSource/ods-ios/issues/602))
- [Tooling] Add GitHub Actions for Gitleaks runs to look for secrets leaks ([#605](https://github.com/Orange-OpenSource/ods-ios/issues/605))
- [DemoApp/Tooling] Update sources header, license file content, build phase and template ([#582](https://github.com/Orange-OpenSource/ods-ios/issues/582))
- [DemoApp/Tooling] Demo app crashes if no URL defined, CI/CD fails because of unversioned xcconfig file (Bug [#612](https://github.com/Orange-OpenSource/ods-ios/issues/612))
- [Tooling] Add Fastlane lane to copy Apps Plus credentials in CI/CD chain for nightly and release builds ([#610](https://github.com/Orange-OpenSource/ods-ios/issues/610))
- [DemoApp] Update technical documentation with versions of tools ([#549](https://github.com/Orange-OpenSource/ods-ios/issues/549))
- [DemoApp/SDK] Apps recirculation ([#64](https://github.com/Orange-OpenSource/ods-ios/issues/64))

## [0.16.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.15.0...0.16.0) - 2024-01-15

- [SDK/DemoApp] Options are overlapped in Setup page of the about module. This needs update in Chips Pickers (Bug [#577](https://github.com/Orange-OpenSource/ods-ios/issues/577))
- [SDK] Size of filter chips is not inconsistent in selected and unselected states (Bug [#594](https://github.com/Orange-OpenSource/ods-ios/issues/594))
- [DemoApp/SDK] Thumbnail of card vertical header first not showing (Bug [#499](https://github.com/Orange-OpenSource/ods-ios/issues/499))
- [DemoApp] Back button renamed after switching from lanscape to portrait mode (Bug [#562](https://github.com/Orange-OpenSource/ods-ios/issues/562))
- [DemoApp] Udpate accessibility label on Functional and Emphasis buttons in demo app ([#546](https://github.com/Orange-OpenSource/ods-ios/issues/546))
- [SDK/DemoApp] Refactor chips component API ([#262](https://github.com/Orange-OpenSource/ods-ios/issues/262))
- [SDK] Size of filter chips is not inconsistent in selected and unselected states (Bug [#594](https://github.com/Orange-OpenSource/ods-ios/issues/594))
- [SDK/DemoApp] Options are overlapped in Setup page of the about module. This needs update in Chips Pickers (Bug [#577](https://github.com/Orange-OpenSource/ods-ios/issues/577))
- [SDK] Size of filter chips is not inconsistent in selected and unselected states (Bug [#594](https://github.com/Orange-OpenSource/ods-ios/issues/594))
- [DemoApp/SDK] Thumbnail of card vertical header first not showing (Bug [#499](https://github.com/Orange-OpenSource/ods-ios/issues/499))
- [DemoApp] Back button renamed after switching from lanscape to portrait mode (Bug [#562](https://github.com/Orange-OpenSource/ods-ios/issues/562))
- [DemoApp] Udpate accessibility label on Functional and Emphasis buttons in demo app ([#546](https://github.com/Orange-OpenSource/ods-ios/issues/546))
- [SDK/DemoApp] Refactor chips component API ([#262](https://github.com/Orange-OpenSource/ods-ios/issues/262))
- [SDK] Update guidelines typography names ([#542](https://github.com/Orange-OpenSource/ods-ios/issues/542))
- [DemoApp] Refactor variant page and entry ([#553](https://github.com/Orange-OpenSource/ods-ios/issues/553))
- [SDK] Accessibility - Group texts in cards for VoiceOver (Bug [#547](https://github.com/Orange-OpenSource/ods-ios/issues/547)) 
- [DemoApp] No title on Component - Lists - Standard and Selection screens (Bug [#545](https://github.com/Orange-OpenSource/ods-ios/issues/545))
- [Tooling] Add script phase to check if AppNews.json files are conform to JSON format
- [DemoApp/SDK] Refactor About module (with view model, errors management and unit tests)
- [DemoApp/SDK] Change wording by replacing ... by elipsis code
- [DemoApp] Fix corrupted AppNews.json file

## [0.15.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.14.0...0.15.0) - 2023-11-14

- [DemoApp/SDK] Fix compilation issues (auto signing for release, remove ios 17 support) ([#529](https://github.com/Orange-OpenSource/ods-ios/issues/529))
- [DemoApp] Review the naming of the wording keys for components ([#523](https://github.com/Orange-OpenSource/ods-ios/issues/523))
- [DemoApp] Show List style and Header and Footer of Sections ([#416](https://github.com/Orange-OpenSource/ods-ios/issues/416))
- [Tooling] Add doctor script to check if project preconditions are filled and update README ([#516](https://github.com/Orange-OpenSource/ods-ios/issues/516))
- [DemoApp/SDK/Tooling] Add new Swiftlint rules and remove some warnings for cleaner source code ([#514](https://github.com/Orange-OpenSource/ods-ios/issues/514))
- [DemoApp] Remove dead code from app with Periphery ([#511](https://github.com/Orange-OpenSource/ods-ios/issues/511))
- [DemoApp/SDK/Tooling] Update source files headers to be compliant with SPDX format ([#497](https://github.com/Orange-OpenSource/ods-ios/issues/497))
- [Tooling] Run tests plan in CI/CD chain ([#506](https://github.com/Orange-OpenSource/ods-ios/issues/506))
- [Tooling] Add Mattermost notifications for build and upload lanes ([#503](https://github.com/Orange-OpenSource/ods-ios/issues/503))
- [Tooling] Downgrade version of activesupport (Cocoapods issue, CI/CD troubleshooting) ([#501](https://github.com/Orange-OpenSource/ods-ios/issues/501))
- [SDK] Internationalization support ([#466](https://github.com/Orange-OpenSource/ods-ios/issues/466))
- [Tooling] Fix security issues with activesupport transitive dependency (cocoapods gem) ([#495](https://github.com/Orange-OpenSource/ods-ios/issues/495)
- [DemoApp/SDK] Update ListItem api to use SwiftUI elements ([#462](https://github.com/Orange-OpenSource/ods-ios/issues/462))
- [DemoApp/SDK] Add accessibility statement in About module ([#119](https://github.com/Orange-OpenSource/ods-ios/issues/119))
- [SDK] Update CardSmall api to use SwiftUI elements ([#485](https://github.com/Orange-OpenSource/ods-ios/issues/485))

## [0.14.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.13.1...0.14.0) - 2023-10-09

- [SDK] Update CardVerticalImageFirst api to use SwiftUI elements ([#481](https://github.com/Orange-OpenSource/ods-ios/issues/481))
- [SDK] Update CardVerticalHeaderFirst api to use SwiftUI elements ([#479](https://github.com/Orange-OpenSource/ods-ios/issues/479))
- [SDK] Update CardHorizontal api to use SwiftUI elements ([#477](https://github.com/Orange-OpenSource/ods-ios/issues/477))
- [SDK] Update Button api to use SwiftUI elements and use a buttonStyle ([#471](https://github.com/Orange-OpenSource/ods-ios/issues/471))
- [SDK] Update banner api to use SwiftUI elements ([#473](https://github.com/Orange-OpenSource/ods-ios/issues/473))
- [SDK] Accessibility Voice over - Application name is a header in the about screen  (Bug [#468](https://github.com/Orange-OpenSource/ods-ios/issues/468))
- [DemoApp/SDK] Update the button emphasis scale naming ([#464](https://github.com/Orange-OpenSource/ods-ios/issues/464))
- [DemoApp] Update configuration to display by default buttons in variable width and without icon  ([#459](https://github.com/Orange-OpenSource/ods-ios/issues/459))
- [DemoApp/SDK] Icon Button Disables not setup ([#426](https://github.com/Orange-OpenSource/ods-ios/issues/426)) 
- [Doc] Add documentation for release process ([#451](https://github.com/Orange-OpenSource/ods-ios/issues/451))
- [DemoApp/SDK] About module: Review The ShareTheApp content because url is presented twice ([#435](https://github.com/Orange-OpenSource/ods-ios/issues/435))

## [0.13.1](https://github.com/Orange-OpenSource/ods-ios/compare/0.13.0...0.13.1) - 2023-09-13

- [DemoApp] Update AppNews for release

## [0.13.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.12.0...0.13.0) - 2023-09-12

- [SDK] Add documentation for the About module ([#441](https://github.com/Orange-OpenSource/ods-ios/issues/441))
- [SDK] Udpate colors for Orange and InnovationCup themes (Bug [#423](https://github.com/Orange-OpenSource/ods-ios/issues/423))
- [DemoApp/SDK] Fix some configuration issues in the About module and About page of the app (Bug [#422](https://github.com/Orange-OpenSource/ods-ios/issues/422))
- [DemoApp] Fix compilation error - App Store icons with alpha ([#433](https://github.com/Orange-OpenSource/ods-ios/issues/433))
- [DemoApp] Update application icons ([#430](https://github.com/Orange-OpenSource/ods-ios/issues/430))
- [DemoApp/SDK] Reorganize repository and Xcode project ([#419](https://github.com/Orange-OpenSource/ods-ios/issues/419))
- [DemoApp/SDK] First version (intermediate) of the About Module with new design and features ([#63](https://github.com/Orange-OpenSource/ods-ios/issues/63))

## [0.12.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.11.2...0.12.0) - 2023-04-14

- [DemoApp/SDK] Add Bottom Sheet component ([#325](https://github.com/Orange-OpenSource/ods-ios/issues/325))
- [SDK] Accessibility issues on Slider (Bug [#385](https://github.com/Orange-OpenSource/ods-ios/issues/385))
- [Build] Update Build scripts to prepare upload on internal portal ([#383](https://github.com/Orange-OpenSource/ods-ios/issues/383))
- [DemoApp] Add animation on Bottom Sheet when oppening and closing, automatically open it when appears ([#377](https://github.com/Orange-OpenSource/ods-ios/issues/377))
- [DemoApp] Customization bottom sheet title uniformity ([#378](https://github.com/Orange-OpenSource/ods-ios/issues/378))
- [DemoApp] Lists icon not displaying (Bug [#375](https://github.com/Orange-OpenSource/ods-ios/issues/375))
- [SDK] Value is not computed well if Slider configured with step less than 1 (Bug [#313](https://github.com/Orange-OpenSource/ods-ios/issues/313))
- [DemoApp] Update About module illustrations with B&W images ([#371](https://github.com/Orange-OpenSource/ods-ios/issues/371))

## [0.11.2](https://github.com/Orange-OpenSource/ods-ios/compare/0.11.1...0.11.2) - 2023-03-27

- [DemoApp] No default item selected on iPad at launch ([#396](https://github.com/Orange-OpenSource/ods-ios/issues/396))
- [SDK] Update Readme and ThirdParty files ([#394](https://github.com/Orange-OpenSource/ods-ios/issues/394))

## [0.11.1](https://github.com/Orange-OpenSource/ods-ios/compare/0.11.0...0.11.1) - 2023-03-16

- [DemoApp] Rename Application([#388](https://github.com/Orange-OpenSource/ods-ios/issues/388))

## [0.11.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.10.0...0.11.0) - 2023-02-28

- [DemoApp/SDK] Fix mistake in wording and documentation ([#364](https://github.com/Orange-OpenSource/ods-ios/issues/364))
- [DemoApp/SDK] Add parameter in CardHorizontal configuration to show/hide divider above buttons ([#362](https://github.com/Orange-OpenSource/ods-ios/issues/362)) 
- [DemoApp/SDK] Cards rename cards labels and components ([#360](https://github.com/Orange-OpenSource/ods-ios/issues/360)) 
- [DemoApp] Use B&W Assets from InnovationCup Theme ([#317](https://github.com/Orange-OpenSource/ods-ios/issues/317))
- [DemoApp] Update cards demo using realistic data ([#354](https://github.com/Orange-OpenSource/ods-ios/issues/354))
- [DemoApp/SDK] Add SideBySide card component ([#56](https://github.com/Orange-OpenSource/ods-ios/issues/56))
- [DemoApp/SDK] Add application description in about module and add demo app description ([#348](https://github.com/Orange-OpenSource/ods-ios/issues/348))

## [0.10.0](https://github.com/Orange-OpenSource/ods-ios/compare/0.9.0...0.10.0) - 2023-02-02

- [DemoApp] Support darkmode in about changelog screen (Bug [#346](https://github.com/Orange-OpenSource/ods-ios/issues/346))
- [DemoApp] Keep the number of expected items when switching item type option(Bug [#347](https://github.com/Orange-OpenSource/ods-ios/issues/347))
- [DemoApp] Spelling click acknowledgement (Bug [#345](https://github.com/Orange-OpenSource/ods-ios/issues/345))
- [DemoApp] Spelling click acknowledgement ([#345](https://github.com/Orange-OpenSource/ods-ios/issues/345))
- [DemoApp] Add new links in the about section ([#342](https://github.com/Orange-OpenSource/ods-ios/issues/342))
- [DemoApp] Add a button in Navigation bar to select theme ([#324](https://github.com/Orange-OpenSource/ods-ios/issues/324))
- [Delivery] Update Changelog file to fix delivery issue ([#340](https://github.com/Orange-OpenSource/ods-ios/issues/340))
- [DemoApp] List Trailing icon action, update text in opened screen ([#326](https://github.com/Orange-OpenSource/ods-ios/issues/326))
- [DemoApp/SDK] Update the Card primary action coverage ([#333](https://github.com/Orange-OpenSource/ods-ios/issues/333) [#331](https://github.com/Orange-OpenSource/ods-ios/issues/331)) 
- [DemoApp] Update changelog file to add url to issues and and update component to see changelog content with links ([#329](https://github.com/Orange-OpenSource/ods-ios/issues/329)) 
- [DemoApp] Add tool bar component ([#31](https://github.com/Orange-OpenSource/ods-ios/issues/31))
- [OrangeTheme] Update to black color (light and dark modes) the Highest emphasis Button text ([#334](https://github.com/Orange-OpenSource/ods-ios/issues/334))
- [DemoApp] Change question mark to exclamation mark in text of badge in tab bar ([#332](https://github.com/Orange-OpenSource/ods-ios/issues/332))
- [SDK] Manage Tap on Action area 1 of a card ([#319](https://github.com/Orange-OpenSource/ods-ios/issues/319))

## [0.9.0] - 2023-01-05

- [DemoApp/SDK] Refactor the lists variant list selection ([#263](https://github.com/Orange-OpenSource/ods-ios/issues/263))
- [DemoApp] Update Bar tab component illustration in landscape ([#304](https://github.com/Orange-OpenSource/ods-ios/issues/304))  
- [Doc] Use ODS Jekyll theme header to display favicons on documentation github pages ([#286](https://github.com/Orange-OpenSource/ods-ios/issues/286)) 
- [DemoApp] Update the Progress indicator variant list selection ([#265](https://github.com/Orange-OpenSource/ods-ios/issues/265)) 
- [DemoApp] Update the Slider variant list selection ([#266](https://github.com/Orange-OpenSource/ods-ios/issues/266))
- [DemoApp] Update default text in TextFields according to the selected capitalization ([#307](https://github.com/Orange-OpenSource/ods-ios/issues/307))

## [0.8.0] - 2022-11-30

- [SDK] Add NOTICE.txt file for Orange Images usage ([#295](https://github.com/Orange-OpenSource/ods-ios/issues/295))
- [DemoApp] Update the Bar Tab variant list selection ([#260](https://github.com/Orange-OpenSource/ods-ios/issues/260))
- [SDK] [Accessibility] Do not vocalize images in ODSSmallCard, ODSCardTitleFirst and ODSCardImageFirst (Bugs [#276](https://github.com/Orange-OpenSource/ods-ios/issues/276), [#275](https://github.com/Orange-OpenSource/ods-ios/issues/275), [#279](https://github.com/Orange-OpenSource/ods-ios/issues/279))
- [DemoApp] Update the Bar Navigation variant list selection ([#259](https://github.com/Orange-OpenSource/ods-ios/issues/259))  
- [DemoApp/SDK] Add banners component ([#51](https://github.com/Orange-OpenSource/ods-ios/issues/51))
- [SDK] Add documentation for bars-tab component ([#289](https://github.com/Orange-OpenSource/ods-ios/issues/289))
- [DemoApp] Guidelines - Typography text description updates ([#257](https://github.com/Orange-OpenSource/ods-ios/issues/257)) 
- [DemoApp/SDK] Update the list of Text fields variants ([#267](https://github.com/Orange-OpenSource/ods-ios/issues/267))
- [DemoApp] Add the play icon to the component's variant lists ([#258](https://github.com/Orange-OpenSource/ods-ios/issues/258))

## [0.7.0] - 2022-11-07

- [DemoApp/SDK] Add theme management and create Orange and InnovationCup themes ([#113](https://github.com/Orange-OpenSource/ods-ios/issues/113))

## [0.6.0] - 2022-10-07

- [DemoApp] Add bottom sheet to allow the user to show/hide the various options on CardTitleFirst ([#250](https://github.com/Orange-OpenSource/ods-ios/issues/250)) 
- [DemoApp] Add bottom sheet to allow the user to show/hide the various options on CardImageFirst ([#251](https://github.com/Orange-OpenSource/ods-ios/issues/251))
- [DemoApp] Add bottom sheet to allow the user to show/hide the subtitle in SmallCard Variant Page ([#249](https://github.com/Orange-OpenSource/ods-ios/issues/249)) 
- [DemoApp/SDK] Update the Button page to list the available button types ([#222](https://github.com/Orange-OpenSource/ods-ios/issues/222))
- [DemoApp] Technical code refactoring for component page presentation ([#248](https://github.com/Orange-OpenSource/ods-ios/issues/248)) 
- [SDK/DemoApp] Technical update to use Small and ImageFirst cards in demo app and modules ([#229](https://github.com/Orange-OpenSource/ods-ios/issues/229)) 
- [DemoApp] Change Chip to switch on List screen for "SecondLineOfText" and "LeadingImage" options ([#228](https://github.com/Orange-OpenSource/ods-ios/issues/228)) 
- [SDK/DemoApp] Add card title first ([#182](https://github.com/Orange-OpenSource/ods-ios/issues/182))
- [SDK/DemoApp] Define a Grid of small cards module and use it in application for components ([#237](https://github.com/Orange-OpenSource/ods-ios/issues/237)) 
- [DemoApp] Rename Module called Card View to Card Collections (2) ([#235](https://github.com/Orange-OpenSource/ods-ios/issues/235))
- [SDK] Add Small Card (Bug [#96](https://github.com/Orange-OpenSource/ods-ios/issues/96))

## [0.5.0] - 2022-09-02

- [DemoApp] Rename Module called Card View to Card Collections (Bug [#219](https://github.com/Orange-OpenSource/ods-ios/issues/219))
- [DemoApp] Add Voice Over on Spacings screen (Bug [#216](https://github.com/Orange-OpenSource/ods-ios/issues/216))
- [DemoApp] Add Voice Over on typography screen (Bug [#214](https://github.com/Orange-OpenSource/ods-ios/issues/214))
- [DemoApp] Update vocalized content on color screen (Bug [#72](https://github.com/Orange-OpenSource/ods-ios/issues/72))
- [DemoApp] Acessibility Voice Over, order of vocalization on Color screen (Bug [#68](https://github.com/Orange-OpenSource/ods-ios/issues/68))
- [SDK] Remove Voice Over on illustration image on the About Screen (Bug [#75](https://github.com/Orange-OpenSource/ods-ios/issues/75))  
- [DemoApp] Update Voice over for Color screen to group elements (Bug [#71](https://github.com/Orange-OpenSource/ods-ios/issues/71)) 
- [SDK] Allow multiline on labels on the about screen (Bug [#76](https://github.com/Orange-OpenSource/ods-ios/issues/76))
- [DemoApp] Voice Over: Add header section for the name ot a group of colors (Bug [#70](https://github.com/Orange-OpenSource/ods-ios/issues/70))
- [DemoApp] Update color description for Dynamic font accessibility (do not truncate text) (Bug [#67](https://github.com/Orange-OpenSource/ods-ios/issues/67))
- [DemoApp] Update the Text Field page ([#160](https://github.com/Orange-OpenSource/ods-ios/issues/160))
- [DemoApp] Update Slider Voice Over Accessibility ([#181](https://github.com/Orange-OpenSource/ods-ios/issues/181))
- [DemoApp/SDK] Update ODSChipPicker API to seperate zero or one element in the single selection ([#198](https://github.com/Orange-OpenSource/ods-ios/issues/198)) 
- [DemoApp/SDK] Refactor sources ([#199](https://github.com/Orange-OpenSource/ods-ios/issues/199))
- [DemoApp] Bad name for card collection in module page (Bug [#103](https://github.com/Orange-OpenSource/ods-ios/issues/103))
- [DemoApp] Add Navigation Bar component ([#57](https://github.com/Orange-OpenSource/ods-ios/issues/57))
- [DemoApp] Cards - outline button update (Bug [#138
- [DemoApp] Do not use fully capitalized words in the legal screen (Bug [#94](https://github.com/Orange-OpenSource/ods-ios/issues/94))
- [DemoApp] Use Chip component in card demo page instead of native ios switches ([#123](https://github.com/Orange-OpenSource/ods-ios/issues/123))
- [DemoApp/SDK] Use ODS spacings in demo app and SDK components ([#158](https://github.com/Orange-OpenSource/ods-ios/issues/158))
- [DemoApp/SDK] Use the ODS font on the demo app and SDK components ([#157](https://github.com/Orange-OpenSource/ods-ios/issues/157))  
- [SDK] Define ODS spacings ([#159](https://github.com/Orange-OpenSource/ods-ios/issues/159))

## [0.4.1] - 2022-07-19

- [SDK] Link code documentation from the DSM without title and description ([#47](https://github.com/Orange-OpenSource/ods-ios/issues/47))
- [SDK] Homogenize documentation structure for all components ([#149](https://github.com/Orange-OpenSource/ods-ios/issues/149))
- [SDK] Review documentation introduction ([#117](https://github.com/Orange-OpenSource/ods-ios/issues/117))
 
## [0.4.0] - 2022-07-08

- [DemoApp/SDK] In List component page, use native color for the toggle, and in card page, display image by default ([#170](https://github.com/Orange-OpenSource/ods-ios/issues/170))
- [DemoApp/SDK] Add List component ([#36](https://github.com/Orange-OpenSource/ods-ios/issues/36))
- [Component] Add Text Selection component and remove Text Edit Menu ([#166](https://github.com/Orange-OpenSource/ods-ios/issues/166))
- [Component] Add Tab Bar page ([#35](https://github.com/Orange-OpenSource/ods-ios/issues/35))
- [DemoApp] Typography style addition, and spacing fix (Bug [#155](https://github.com/Orange-OpenSource/ods-ios/issues/155))
- [DemoApp/SDK] Add slider action on bar tap ([#128](https://github.com/Orange-OpenSource/ods-ios/issues/128))
- [DemoApp] Design review Sprint 11 (background colours, shadows, ...) ([#161](https://github.com/Orange-OpenSource/ods-ios/issues/161))
- [DemoApp/SDK] Add Chip component ([#150](https://github.com/Orange-OpenSource/ods-ios/issues/150))
- [DemoApp] Typographie : Update font style list (add id) ([#42](https://github.com/Orange-OpenSource/ods-ios/issues/42))
- [DemoApp] Demo App clean-up ([#124](https://github.com/Orange-OpenSource/ods-ios/issues/124))
- [DemoApp] Add missing component illustrations (Bug [#130](https://github.com/Orange-OpenSource/ods-ios/issues/130))
- [DemoApp] Show build number and build type in about screen ([#136](https://github.com/Orange-OpenSource/ods-ios/issues/136))
- [DemoApp] Add illustration on card detailed page ([#131](https://github.com/Orange-OpenSource/ods-ios/issues/131))
- [DemoApp] Update ODS-Guideline, Typography screen ([#42](https://github.com/Orange-OpenSource/ods-ios/issues/42))
- [DemoApp] Display components sorted by name (Bug [#129](https://github.com/Orange-OpenSource/ods-ios/issues/129))
- [DemoApp] Card content with longer text (Bug [#110](https://github.com/Orange-OpenSource/ods-ios/issues/110))
- [DemoApp] Update title for cards in components screen (Bug [#97](https://github.com/Orange-OpenSource/ods-ios/issues/97))

## [0.3.0] - 2022-06-10
### Changed
- [DemoApp] Update text button and shaped button pages with new design specifications
- [DemoApp] Remove Imagery and Iconography from GuideLines screen ([#112](https://github.com/Orange-OpenSource/ods-ios/issues/112))

### Added

### Bugs
- [DemoApp] Colour pop-up displays wrong color (Bug [#107](https://github.com/Orange-OpenSource/ods-ios/issues/107))
- [DemoApp] Card bad display (Bug [#102](https://github.com/Orange-OpenSource/ods-ios/issues/102))
- [DemoApp] Progress indicator not centered (Bug [#101](https://github.com/Orange-OpenSource/ods-ios/issues/101))

## [0.2.0] - 2022-05-05
### Changed
- [SDK] Colors
- [SDK] About page
- [DemoApp] Rename App to ODS Demo
- [DemoApp] Colors update

### Added
- [SDK] Component card small
- [SDK] Module card view
- [DemoApp] Component card page
- [DemoApp] Module card view page
- [DemoApp] Guidelines page
- [DemoApp] App name vocalization
- [DemoApp] About page
- [DemoApp] Component page
- [DemoApp] New module page
- [DemoApp] Automate the versioning in the about page
- [DemoApp] Release note management
- [DemoApp] High level App navigation
- [DemoApp] Slider component
- [DemoApp] Edit Text component
