//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

extension View {
    func readTabBarHeight(_ onChange: @escaping (CGFloat) -> Void) -> some View {
        configureTabBar { controller, _ in
            onChange(controller.tabBar.bounds.height)
        }
    }

    func configureTabBar(configurator: @escaping (UITabBarController, Bool) -> Void) -> some View {
        background(TabBarConfigurator(configurator: configurator))
    }
}

struct TabBarConfigurator: UIViewControllerRepresentable {

    // =======================
    // MARK: Stored Properties
    // =======================

    let configurator: (UITabBarController, Bool) -> Void

    // ============================================
    // MARK: UIViewControllerRepresentable Protocol
    // ============================================

    func makeUIViewController(context: Context) -> TabBarConfigurationViewController {
        TabBarConfigurationViewController(configurator: configurator)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class TabBarConfigurationViewController: UIViewController {

    // =======================
    // MARK: Stored Properties
    // =======================

    private var configurator: (UITabBarController, Bool) -> Void

    // ==================
    // MARK: Initializers
    // ==================

    init(configurator: @escaping (UITabBarController, Bool) -> Void) {
        self.configurator = configurator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ===============================
    // MARK: UIViewController Override
    // ===============================

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let tabBarController = tabBarController {
            configurator(tabBarController, true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let tabBarController = tabBarController {
            configurator(tabBarController, true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let tabBarController = tabBarController {
            configurator(tabBarController, false)
        }
    }
}
