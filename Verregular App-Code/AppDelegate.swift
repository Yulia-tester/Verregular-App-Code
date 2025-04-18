//
//  AppDelegate.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [HomeViewController()]
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }

}

