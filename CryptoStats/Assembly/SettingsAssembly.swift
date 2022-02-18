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
    
    static func makeCurrencyPickerScreen() -> (CurrencyPickerViewController, CurrencyPickerViewModel) {
        let viewController = CurrencyPickerViewController.instaniate()
        
        let networkService = NetworkService()
        let simpleInteractor = SimpleInteractor(networkService: networkService)
        
        let viewModel = CurrencyPickerViewModel(simpleInteractor: simpleInteractor)
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
    static func makeColorThemePickerScreen() -> (ColorThemePickerViewController, ColorThemePickerViewModel) {
        let viewController = ColorThemePickerViewController.instaniate()
        let viewModel = ColorThemePickerViewModel()
        viewController.viewModel = viewModel
        
        return (viewController, viewModel)
    }
    
}
