//
//  CoinsAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class CoinsAssembly: Assembly {
    static func makeCoinsTableScreen() -> CoinsTableViewController {
        let viewController = CoinsTableViewController.instaniate()
        let viewModel = CoinsTableViewModel(networkService: DefaultNetworkService())
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func makeCoinDetailsScreen() -> CoinDetailsViewController {
        let viewController = CoinDetailsViewController.instaniate()
        
        return viewController
    }
}
