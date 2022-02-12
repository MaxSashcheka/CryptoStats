//
//  MainTabBarController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let coinsCoordinator = CoinsCoordinator(navigationController: UINavigationController())
    let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.backgroundColor = .secondarySystemBackground
//        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.configureWithDefaultBackground()

        coinsCoordinator.start()
        settingsCoordinator.start()
        viewControllers = [coinsCoordinator.navigationController, settingsCoordinator.navigationController]
    }

}
