//
//  AppDelegate.swift
//  Take-Your-News
//
//  Created by Anastasiya on 16/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let basicAuth: String? = UserDefaults.standard.string(forKey: "basicAuth")

        if basicAuth == nil {
        let viewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            window?.rootViewController = viewController
        } else {
            let viewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            viewController.modalPresentationStyle = .fullScreen
            window?.rootViewController = viewController
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

