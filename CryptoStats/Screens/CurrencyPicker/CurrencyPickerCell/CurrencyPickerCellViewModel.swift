//
//  CurrencyPickerCellViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import Foundation

class CurrencyPickerCellViewModel {
    let title: NSAttributedString
    var isSelected: Bool
    
    init(title: NSAttributedString, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
