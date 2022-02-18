//
//  SettingsCoordinator.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

class SettingsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        
        let (viewController, viewModel) = SettingsAssembly.makeSettingsScreen()
        viewController.tabBarItem = UITabBarItem(title: "Settings",
                                                 image: UIImage(systemName: "gearshape"),
                                                 selectedImage: UIImage(systemName: "gearshape.fill"))
        
        viewModel.changeColorTheme = { [weak self] in
            self?.initializeColorThemePickerScreenAndShow()
        }
        viewModel.changeCurrency = { [weak self] in
            self?.initializeCurrencyPickerScreenAndShow()
        }
        
        pushViewController(viewController)

    }
    
    func initializeColorThemePickerScreenAndShow() {
        let (viewController, viewModel) = SettingsAssembly.makeColorThemePickerScreen()
        
        pushViewController(viewController, animated: true)
    }
    
    func initializeCurrencyPickerScreenAndShow() {
        let (viewController, viewModel) = SettingsAssembly.makeCurrencyPickerScreen()
        
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
