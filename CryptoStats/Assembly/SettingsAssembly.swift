//
//  SettingsAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class SettingsAssembly: Assembly {
    static func makeSettingsScreen() -> (SettingsViewController, SettingsViewModel) {
        let viewController = SettingsViewController.instaniate()
        let viewModel = SettingsViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
}
