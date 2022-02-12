//
//  MainCoordinator.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
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
        
        if let coinDetailsViewController = fromViewController as? CoinDetailsViewController {
            childDidFinish(coinDetailsViewController.coordinator)
        }
        
    }
    
}
