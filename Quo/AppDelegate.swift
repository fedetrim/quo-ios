//
//  AppDelegate.swift
//  Quo
//
//  Created by Federico Trimboli on 04/03/2018.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = window!.rootViewController as! UITabBarController
        tabBarController.delegate = TabBarControllerDelegate.shared
        
        return true
    }

}
