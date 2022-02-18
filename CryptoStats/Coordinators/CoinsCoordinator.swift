//
//  Coordinator.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

class CoinsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    lazy var backTransition: VoidClosure = { [weak self] in
        self?.navigationController.popViewController(animated: true)
    }
    
    func start() {
        navigationController.delegate = self
        
        let (viewController, viewModel) = CoinsAssembly.makeCoinsTableScreen()
        viewController.tabBarItem = UITabBarItem(title: "Settings",
                                                 image: UIImage(systemName: "bitcoinsign.square"),
                                                 selectedImage: UIImage(systemName: "bitcoinsign.square.fill"))
        viewModel.showCryptoCoinDetailsTransition = { [weak self] coinId in
            self?.initializeDetailInfoScreenAndShow(forCoinId: coinId)
        }
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func initializeDetailInfoScreenAndShow(forCoinId id: String) {
        let (viewController, viewModel) = CoinsAssembly.makeCoinDetailsScreen(withCoinId: id)
        
        pushViewController(viewController)
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
    
//    func navigationController(_ navigationController: UINavigationController,
//                              didShow viewController: UIViewController, animated: Bool) {
//        print(childCoordinators)
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
//        if navigationController.viewControllers.contains(fromViewController) { return }
//
//        if let coinDetailsViewController = fromViewController as? CoinDetailsViewController {
//            childDidFinish(coinDetailsViewController.coordinator)
//        }
//        print(childCoordinators)
//    }
}
