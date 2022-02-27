//
//  WalletCoinViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 27.02.22.
//

import Foundation

class WalletCoinViewModel: CryptoCoinViewModel {
    var count: Float
    
    init(id: String,
         imageURL: URL,
         symbol: String,
         name: String,
         currentPrice: Float,
         highestPricePerLastDay: Float,
         lowestPricePerLastDay: Float,
         priceChangePercentagePerLastDay: Float,
         count: Float,
         marketCapRank: Int) {
        self.count = count
        
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
