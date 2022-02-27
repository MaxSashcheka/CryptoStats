//
//  WalletAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import Foundation

class WalletAssembly: Assembly {
    static func makeWalletScreen() -> (WalletViewController, WalletViewModel) {
        let viewController = WalletViewController()
        
        let networkService = NetworkService()
        let coinsInteractor = CoinsInteractor(networkService: networkService)
        
        let viewModel = WalletViewModel(coinsInteractor: coinsInteractor)
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    static func makeAddCoinScreen() -> (WalletAddCoinViewController, WalletAddCoinViewModel) {
        let viewController = WalletAddCoinViewController()
        
        let networkService = NetworkService()
        let coinsInteractor = CoinsInteractor(networkService: networkService)
        
        let viewModel = WalletAddCoinViewModel(coinsInteractor: coinsInteractor)
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
}
