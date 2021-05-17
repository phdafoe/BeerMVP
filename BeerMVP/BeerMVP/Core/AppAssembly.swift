
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
    
    fileprivate func customUI(){
        let navBar = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        let toolBar = UIToolbar.appearance()
        
        navBar.barTintColor = Helpers.Colores().GRAY_NAV
        tabBar.barTintColor = Helpers.Colores().GRAY_NAV
        
        toolBar.barTintColor = Helpers.Colores().GRAY_NAV
        toolBar.tintColor = Helpers.Colores().GRAY_NAV
        
        navBar.tintColor = Helpers.Colores().BLANCO_TEXTO_NAV
        tabBar.tintColor = Helpers.Colores().RED_ICON
        
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  Helpers.Colores().BLANCO_TEXTO_NAV]
    }
}
