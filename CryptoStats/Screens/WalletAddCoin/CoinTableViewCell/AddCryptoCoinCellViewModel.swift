//
//  AddCryptoCoinCellViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 27.02.22.
//

import Foundation

class AddCryptoCoinCellViewModel: CryptoCoinViewModel {
    var isSelected: Bool
    
    init(id: String,
         imageURL: URL,
         symbol: String,
         name: String,
         currentPrice: Float,
         highestPricePerLastDay: Float,
         lowestPricePerLastDay: Float,
         priceChangePercentagePerLastDay: Float,
         isSelected: Bool,
         marketCapRank: Int) {
        self.isSelected = isSelected
        
        super.init(id: id,
                   imageURL: imageURL,
                   symbol: symbol,
                   name: name,
                   currentPrice: currentPrice,
                   highestPricePerLastDay: highestPricePerLastDay,
                   lowestPricePerLastDay: lowestPricePerLastDay,
                   priceChangePercentagePerLastDay: priceChangePercentagePerLastDay,
                   marketCapRank: marketCapRank)
    }
}
