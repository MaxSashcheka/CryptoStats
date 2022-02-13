//
//  CoinsAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class CoinsAssembly: Assembly {
    static func makeCoinsTableScreen() -> (CoinsTableViewController, CoinsTableViewModel) {
        let viewController = CoinsTableViewController.instaniate()
        let viewModel = CoinsTableViewModel(networkService: NetworkService())
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    static func makeCoinDetailsScreen(withCoinId coinId: String) -> (CoinDetailsViewController, CoinDetailsViewModel) {
        let viewController = CoinDetailsViewController.instaniate()
        let viewModel = CoinDetailsViewModel(networkService: NetworkService(), selectedCoinId: coinId)
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
