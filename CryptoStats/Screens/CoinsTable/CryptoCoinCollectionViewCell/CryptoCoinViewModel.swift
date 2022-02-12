//
//  CryptoCoinViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

class CryptoCoinViewModel {
    let symbol: String
    let name: String
    let imageURL: URL
    let currentPrice: Float
    let highestPricePerLastDay: Float
    let lowestPricePerLastDay: Float
    let priceChangePercentagePerLastDay: Float
    
    init(imageURL: URL,
         symbol: String,
         name: String,
         currentPrice: Float,
         highestPricePerLastDay: Float,
         lowestPricePerLastDay: Float,
         priceChangePercentagePerLastDay: Float) {
        self.imageURL = imageURL
        self.symbol = symbol
        self.name = name
        self.currentPrice = currentPrice
        self.highestPricePerLastDay = highestPricePerLastDay
        self.lowestPricePerLastDay = lowestPricePerLastDay
        self.priceChangePercentagePerLastDay = priceChangePercentagePerLastDay
    }
}
