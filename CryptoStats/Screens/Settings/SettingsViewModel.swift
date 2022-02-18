//
//  SettingsViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 13.02.22.
//

import Foundation
import UIKit.UIImage
import RxSwift
import RxRelay

class SettingsViewModel {
    
    // MARK: - Transitions
    var changeColorTheme: VoidClosure?
    var changeCurrency: VoidClosure?
    
    // MARK: - Variables
    var activeSettingsViewModels = BehaviorRelay<[SettingsCellViewModel]>(value: [])
    
    var numberOfItems: Int {
        activeSettingsViewModels.value.count
    }
    
    init() {
        setupCellViewModels()
    }
    
    func selectCell(at indexPath: IndexPath) {
        settingsViewModels[indexPath.row].didSelectClosure?()
    }
    
}

// MARK: - SettingsViewModel+SetupCellViewModels

private extension SettingsViewModel {
    func setupCellViewModels() {
        activeSettingsViewModels.accept(settingsViewModels)
    }
    var settingsViewModels: [SettingsCellViewModel] {
        let colorThemePickerViewModel = SettingsCellViewModel(title: attributedSettingTitle("Change color theme"), image: UIImage(systemName: "eyedropper.halffull"))
        colorThemePickerViewModel.didSelectClosure = changeColorTheme
        
        let currencyPickerViewModel = SettingsCellViewModel(title: attributedSettingTitle("Change current currenccy"), image: UIImage(systemName: "coloncurrencysign.circle"))
        currencyPickerViewModel.didSelectClosure = changeCurrency
        
        return [colorThemePickerViewModel, currencyPickerViewModel]
    }
    
    func attributedSettingTitle(_ title: String) -> NSAttributedString {
        return NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular),
                                                                .foregroundColor: UIColor.black])
    }
    
}

// eyedropper.halffull
// coloncurrencysign.circle
