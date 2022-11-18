//
//  TabBarController.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension TabBarController {
    private func setupLayout() {
        
        let mainViewController = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.tabBarItem = UITabBarItem(title: "Main",
                                                           image: TabBarImages.main.image,
                                                           selectedImage: TabBarImages.main.selectedImage)
        
        let favoritesViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites",
                                                                image: TabBarImages.favorites.image,
                                                                selectedImage: TabBarImages.favorites.selectedImage)
        
        setViewControllers([mainNavigationController, favoritesNavigationController], animated: false)
    }
}
