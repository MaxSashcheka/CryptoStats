//
//  WalletCoordinator.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import UIKit

class WalletCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let (viewController, viewModel) = WalletAssembly.makeWalletScreen()
        viewController.tabBarItem = UITabBarItem(title: "My wallet",
                                                 image: UIImage(systemName: "wallet.pass"),
                                                 selectedImage: UIImage(systemName: "wallet.pass.fill"))
        
        viewModel.showAddCoinTransition = { [weak self] in
            self?.initializeWalletAddCoinScreenAndShow()
        }
        
        pushViewController(viewController)
    }
    
    func initializeWalletAddCoinScreenAndShow() {
        let (viewController, viewModel) = WalletAssembly.makeAddCoinScreen()
        viewModel.dismissTransition = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        pushViewController(viewController, animated: true)
    }

    
    func childDidFinish(_ child: Coordinator?) {
        print(childCoordinators)
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        print(childCoordinators)

    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        
//        if let coinDetailsViewController = fromViewController as? CoinDetailsViewController {
//            childDidFinish(coinDetailsViewController.coordinator)
//        }
        
    }
    
    
}
