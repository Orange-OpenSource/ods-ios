//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import SwiftUI

extension View {
    func readTabBarHeight( _ onChange: @escaping (CGFloat) -> Void) -> some View {
        self.configureTabBar { controller, _ in
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

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
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

        if let tabBarController = self.tabBarController {
            configurator(tabBarController, true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let tabBarController = self.tabBarController {
            configurator(tabBarController, false)
        }
    }
}
