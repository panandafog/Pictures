//
//  TabBarViewController.swift
//  Pictures
//
//  Created by Andrey on 20.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let tab1 = GeneratePictureViewController()
        let tab1Item = UITabBarItem(
            title: "Tab.GeneratePicture".localized,
            image:  UIImage(named: "camera")?.resizedForTabBar,
            tag: 1
        )
        tab1.tabBarItem = tab1Item
        
        let tab2 = FavouritesViewController()
        let tab2Item = UITabBarItem(
            title: "Tab.FavouritePictures".localized,
            image: UIImage(named: "star")?.resizedForTabBar,
            tag: 2
        )
        tab2.tabBarItem = tab2Item
        
        viewControllers = [tab1, tab2]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {

}
