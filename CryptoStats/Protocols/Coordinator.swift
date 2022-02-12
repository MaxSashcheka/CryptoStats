//
//  Coordinator.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func start()
}

extension Coordinator {
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}

