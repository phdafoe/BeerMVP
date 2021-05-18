//
//  HomeTabBarViewController.swift
//  PruebaMarvel
//
//  Created by Andres Felipe Ocampo Eljaiek
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneViewController = ListBeersCoordinator.buildNavigation()
        let twoViewController = SearchCoordinator.buildNavigation()

        let customOneTabBarItem = UITabBarItem(title: "Characters",
                                               image: UIImage(named: "top-icon")?.withRenderingMode(.alwaysOriginal),
                                               selectedImage: UIImage(named: "top-icon"))
        
        let customTwoTabBarItem = UITabBarItem(title: "Comics",
                                               image: UIImage(named: "ver-icon")?.withRenderingMode(.alwaysOriginal),
                                               selectedImage: UIImage(named: "ver-icon"))
        
        oneViewController.tabBarItem = customOneTabBarItem
        twoViewController.tabBarItem = customTwoTabBarItem
        self.viewControllers = [oneViewController, twoViewController]
    }

}
