//
//  AppDelegate.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 17/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var appAssembly: AppAssemblyProtocol = AppAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let windowDes = window {
            appAssembly.applicationShowInitVC(windowDes)
        }
        return true
    }


}

