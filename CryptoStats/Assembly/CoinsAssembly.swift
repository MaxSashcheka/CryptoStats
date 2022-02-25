//
//  CoinsAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class CoinsAssembly: Assembly {
    static func makeCoinsTableScreen() -> (CoinsTableViewController, CoinsTableViewModel) {
        let viewController = CoinsTableViewController()
        
        let networkService = NetworkService()
        let coinsInteractor = CoinsInteractor(networkService: networkService)
        let viewModel = CoinsTableViewModel(coinsInteractor: coinsInteractor)
        
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    static func makeCoinDetailsScreen(withCryptoCoinCurrentData cryptoCoinCurrentData: CryptoCoinCurrentData) -> (CoinDetailsViewController, CoinDetailsViewModel) {
        let viewController = CoinDetailsViewController()
        let viewModel = CoinDetailsViewModel(cryptoCoinCurrentData: cryptoCoinCurrentData)
    
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
}
