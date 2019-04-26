//
//  AppDelegate.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 05/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        coordinator = MainCoordinator(navigationController: navigationController)
        
        coordinator?.start(animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}
