//
//  AppDelegate.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        let tabBarViewController = TabBarViewController()
        navigationController.pushViewController(
            tabBarViewController,
            animated: false
        )
        window = UIWindow()
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

