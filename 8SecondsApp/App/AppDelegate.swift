//
//  AppDelegate.swift
//  8SecondsApp
//
//  Created by Ataberk Canıtez on 11.03.2020.
//  Copyright © 2020 Ataberk Canıtez. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        let window = UIWindow()
        let viewController = UINavigationController(rootViewController: LoginController())

        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        
        
        
        
        return true
    }


}

