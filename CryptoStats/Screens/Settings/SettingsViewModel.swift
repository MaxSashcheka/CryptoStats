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
    var settingsCellViewModels = BehaviorRelay<[SettingsCellViewModel]>(value: [])
    
    var numberOfItems: Int {
        settingsCellViewModels.value.count
    }
    
    init() {
        setupSettingsViewModels()
    }
    
}

// MARK: - SettingsViewModel+SetupCellViewModels
private extension SettingsViewModel {
    func setupSettingsViewModels() {
        let colorThemePickerViewModel = SettingsCellViewModel(title: attributedSettingTitle("Change color theme"), image: UIImage(systemName: "eyedropper.halffull"))
        colorThemePickerViewModel.didSelectClosure = changeColorTheme
        
        let currencyPickerViewModel = SettingsCellViewModel(title: attributedSettingTitle("Change current currenccy"), image: UIImage(systemName: "coloncurrencysign.circle"))
        currencyPickerViewModel.didSelectClosure = changeCurrency
        
        settingsCellViewModels.accept([colorThemePickerViewModel, currencyPickerViewModel])
    }
    
    func attributedSettingTitle(_ title: String) -> NSAttributedString {
        return NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular),
                                                                .foregroundColor: UIColor.black])
    }
}

// eyedropper.halffull
// coloncurrencysign.circle
