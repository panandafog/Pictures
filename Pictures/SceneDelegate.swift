//
//  SceneDelegate.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let tabBarViewController = TabBarViewController()
        navigationController.pushViewController(
            tabBarViewController,
            animated: false
        )
        
        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
