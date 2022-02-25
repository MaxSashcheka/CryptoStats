//
//  MainTabBarController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let coinsCoordinator = CoinsCoordinator(navigationController: UINavigationController())
    let walletCoordinator = WalletCoordinator(navigationController: UINavigationController())
    let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinsCoordinator.start()
        walletCoordinator.start()
        settingsCoordinator.start()
        viewControllers = [coinsCoordinator.navigationController, walletCoordinator.navigationController, settingsCoordinator.navigationController]
    }

}
