//  AppAssembly.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import UIKit

protocol AppAssemblyProtocol: class {
    func applicationShowInitVC(_ window: UIWindow)
}

final class AppAssembly: AppAssemblyProtocol {

    private (set) var actualViewController: UIViewController!

    internal func applicationShowInitVC(_ window: UIWindow) {
        self.customUI()
        actualViewController = ListComicsAssembly.buildNavigation()
        window.rootViewController = actualViewController
        window.makeKeyAndVisible()
    }

    fileprivate func customUI() {
        let navBar = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        let toolBar = UIToolbar.appearance()

        navBar.barTintColor = Helpers.Colores().grayNav
        tabBar.barTintColor = Helpers.Colores().grayNav

        toolBar.barTintColor = Helpers.Colores().grayNav
        toolBar.tintColor = Helpers.Colores().grayNav

        navBar.tintColor = Helpers.Colores().blancoTextoNav
        tabBar.tintColor = Helpers.Colores().redIcon

        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Helpers.Colores().blancoTextoNav]
    }
}
