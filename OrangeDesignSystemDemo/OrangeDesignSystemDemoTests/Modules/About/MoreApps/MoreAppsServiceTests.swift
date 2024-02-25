//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import Foundation
@testable import OrangeDesignSystem
import XCTest

// swiftlint:disable line_length
/// Helps to test the `MoreAppsService` to check if JSON data (in local mocks) are well processed
final class MoreAppsServiceTests: XCTestCase {

    /// Assertions on the apps objects read from some mock JSON to test both mapper and service layers
    func testMoreAppsServiceApps() async {
        // Given
        let moreAppsService = RecirculationService(repository: MockMoreAppsRepository(feedURL: URL(string: "https://opensource.orange.com/")!))

        // When
        var apps = [RecirculationAppDetails]()
        do {
            let moreAppsList = try await moreAppsService.availableAppsList()
            apps = moreAppsList.apps
        } catch {
            XCTFail("Not supposed to throw some error now")
        }

        // Then
        XCTAssertTrue(apps.count == 3)

        let app1 = apps[0]
        XCTAssertEqual(app1.title, "Airbox Lite")
        XCTAssertEqual(app1.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/1140508591.png"))
        XCTAssertEqual(app1.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id1140508591?pt=20021&ct=XIsvjJaTcL&mt=8"))
        XCTAssertEqual(app1.description, "Avec la nouvelle application Airbox Lite, vous pouvez facilement gérer votre routeur 4G Orange (Airbox, Airbox Auto, Flybox, Airbox inclus dans la nouvelle Livebox, Airbox Sosh). Avec elle, vous pouvez:\n- Vérifiez l'état de votre niveau de connexion et de la batterie 4G.\n- Vérifiez le volume de données consommées ou l'itinérance nationale.\n- Gérer la configuration du Wi-Fi (mot de passe, le nom du réseau, Wi-Fi invité, etc.).\n- Bloquer l'accès à Internet à certains équipements.\n \nAirbox Lite est compatible avec la plupart des routeurs 4G Orange : E5372, E5577, B310, E5180, E8377…")

        let app2 = apps[1]
        XCTAssertEqual(app2.title, "Kids Ready")
        XCTAssertEqual(app2.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/1395472679.png"))
        XCTAssertEqual(app2.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id1395472679?pt=20021&ct=XIsvjJaTcL&mt=8"))
        XCTAssertNil(app2.description)

        let app3 = apps[2]
        XCTAssertEqual(app3.title, "Jazztel")
        XCTAssertEqual(app3.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/1264689297.png"))
        XCTAssertEqual(app3.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id1264689297?pt=20021&ct=XIsvjJaTcL&mt=8"))
        XCTAssertNil(app3.description)
    }

    /// Assertions on the sections objects read from some mock JSON to test both mapper and service layers
    func testMoreAppsServiceSections() async {
        // Given
        let moreAppsService = RecirculationService(repository: MockMoreAppsRepository(feedURL: URL(string: "https://opensource.orange.com/")!))

        // When

        var sections = [RecirculationAppsListSection]()
        do {
            let moreAppsList = try await moreAppsService.availableAppsList()
            sections = moreAppsList.sections
        } catch {
            XCTFail("Not supposed to throw some error now")
        }

        // Then
        XCTAssertTrue(sections.count == 2)

        let section1 = sections[0]
        XCTAssertEqual(section1.description, "Business apps")
        XCTAssertEqual(section1.apps.count, 2)

        let section1app1 = section1.apps[0]
        XCTAssertEqual(section1app1.title, "Orange Pro, espace client pro")
        XCTAssertEqual(section1app1.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/1064733638.png"))
        XCTAssertEqual(section1app1.description, "Découvrez Orange Pro, l'application mobile pour gérer ses offres, options et services.  A tous nos clients du marché PRO et PME, Orange pro est l’application qui vous est dédiée ! \nQuels sont les fonctionnalités de l’application ? Laisser nous vous expliquer.\nVous pouvez :\n•\tgérer ses contras contrats Internet, fixe et/ou mobile\n•\tconsulter et télécharger vos factures\n•\tavoir un accès au suivi conso et on est alerté en cas de hors forfait\n•\tparamétrer les services d’une ligne mobile : code PUK, suspension de la ligne en cas de perte ou vol d'un mobile et désimlocker un téléphone... \n•\tacheter des recharges data en France et à l’étranger pour chaque ligne mobile. Cet achat est possible par carte bancaire ou par facture entreprise\n•\tparamétrer les services d’un téléphone fixe : renvoi d’appel, secret permanent, filtrer les appels sortants et présentation du numéro\n•\tparamétrer les services d’une ligne Internet et TV : consultation des identifiants, modification du mot de passe Internet\n•\tdemander à tout moment de l’aide à Djingo, l’assistant virtuel \n•\tprendre un RDV en boutique \n•\tjoindre le service commercial par messaging ou en étant rappelé\n\nUne rubrique spéciale pour gérer votre réseau et votre Livebox. Vous pouvez :\n\n•\tBénéficier des tutoriels pour votre Livebox ainsi que d’un accompagnement sur les voyants de la box\n•\tVisualiser l'état des services Internet, téléphone et TV lorsque votre smartphone est connecté à votre Livebox Pro\n•\tGérer la Livebox : après avoir saisi le mot de passe d'administration de la Livebox, vous pouvez partager et personnaliser la clé Wi-Fi, de la Livebox et modifier le nom des équipements connectés.\n•\tVérifiez la qualité du réseau disponible sur votre smartphone avec le test de débit Wi-Fi\n•\tUne question sur votre Livebox, sur votre décodeur ou votre téléphone fixe ? Utiliser l'autodiagnostic d'Orange : guidé  en fonction de vos appareils, vous obtiendrez toutes les réponses à vos questions sur l'utilisation et le dépannage de vos différents services. \n\nN'attendez plus, téléchargez l'application mobile Orange Pro pour profiter de l'ensemble de ces services.\n\nA très vite sur Orange Pro, l'espace client des professionnels !")
        XCTAssertEqual(section1app1.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id1064733638?pt=20021&ct=XIsvjJaTcL&mt=8"))

        let section1app2 = section1.apps[1]
        XCTAssertEqual(section1app2.title, "Orange Business Lounge")
        XCTAssertEqual(section1app2.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/472332600.png"))
        XCTAssertEqual(section1app2.description, "Grâce à votre ligne mobile entreprise Orange Business Services, vous disposez d’un espace qui vous est dédié. Notre objectif : vous accompagner de façon efficace et personnalisée dans l’utilisation de votre mobile professionnel.\nOrange Business Lounge est une application que nous avons conçue avec vous, afin d’être intuitive et adaptée à vos principaux besoins :\n-          L’état de votre suivi conso et la qualité du réseau accessibles dès la page d’accueil\n-          Des alertes en cas de risque de débit réduit et la possibilité d’acheter une recharge data en quelques clics\n-          Un accompagnement pour préparer vos voyages à l’étranger : mon forfait couvre-t-il cette destination ? Quelle recharge est disponible ? Quel numéro de service client appeler depuis l’étranger ?\n-          Une assistance pour ne pas vous laisser sans solution : suspendre ma ligne en cas de vol ou perte de mon mobile (j’accède à mon compte sur la version web depuis une tablette, un PC ou un Mac ), débloquer mon code PUK, diagnostiquer un problème que je rencontre avec mon mobile, etc.\n \nN’hésitez pas à nous contacter pour nous faire part de tous vos points d’amélioration à l’adresse suivante : contact.businesslounge@orange.com\nL'application Orange Business Lounge est compatible mais non optimisée pour les tablettes et peut donc comporter quelques bugs.")
        XCTAssertEqual(section1app2.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id472332600?pt=20021&ct=XIsvjJaTcL&mt=8"))

        let section2 = sections[1]
        XCTAssertEqual(section2.description, "Consumer")
        XCTAssertEqual(section2.apps.count, 1)

        let section2app1 = section2.apps[0]
        XCTAssertEqual(section2app1.title, "Orange Radio")
        XCTAssertEqual(section2app1.iconURL, URL(string: "https://appsplus-oma.apps-details.com/icons/1201284975.png"))
        XCTAssertEqual(section2app1.description, "Orange Radio offre un accès gratuit à des milliers de radio internet et de podcasts de par le monde; Découvrez la sélection orange pour votre pays et des titres à l'écoute, gérez vos radios favorites et retrouvez vos titres préférés sur des services de musique à la demande avec une expérience unique.\n\nLa montre Pebble, AppRadio et CarPlay ne sont plus pris en charge dans l'application.")
        XCTAssertEqual(section2app1.storeURL, URL(string: "https://itunes.apple.com/app/apple-store/id1201284975?pt=20021&ct=XIsvjJaTcL&mt=8"))
    }

    // ===============
    // MARK: - Helpers
    // ===============

    private struct MockMoreAppsRepository: RecirculationRepositoryProtocol {

        private let feedURL: URL
        private let urlSessionConfiguration: URLSessionConfiguration

        var localCacheLocation: URL? { nil }

        init(feedURL: URL, urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
            self.feedURL = feedURL
            self.urlSessionConfiguration = urlSessionConfiguration
        }

        func availableAppsList() -> RecirculationAppsList {
            let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusMock", ofType: "json", inBundleOf: MoreAppsServiceTests.self)
            guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
                fatalError("Failed to convert the mock JSON for tests!")
            }
            guard let appsPlusDTOMock = try? JSONDecoder().decode(AppsPlusDTO.self, from: jsonRawData) else {
                fatalError("Failed to process the JSON mock data!")
            }

            let mapper = AppsPlusRecirculationMapper()
            let moreAppsAppDetails = mapper.appsDetails(from: appsPlusDTOMock.items[0])
            let moreAppsSections = mapper.appsSections(from: appsPlusDTOMock.items[0])

            return RecirculationAppsList(sections: moreAppsSections, apps: moreAppsAppDetails)
        }
    }
}
// swiftlint:enable line_length
