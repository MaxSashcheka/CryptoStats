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
        let viewModel = WalletViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
}
