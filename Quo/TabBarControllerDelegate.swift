//
//  TabBarControllerDelegate.swift
//  Quo
//
//  Created by Federico Trimboli on 19/03/2018.
//

import UIKit

final class TabBarControllerDelegate: NSObject, UITabBarControllerDelegate {
    
    static let shared = TabBarControllerDelegate()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let _ = viewController as? CreateQuoteViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: CreateQuoteViewController.self))
            let vc = storyboard.instantiateViewController(withIdentifier: "CreateQuoteViewController") as! CreateQuoteViewController
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.barStyle = .blackTranslucent
            UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
}
