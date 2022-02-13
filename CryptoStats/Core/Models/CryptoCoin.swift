//
//  Coin.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

struct CryptoCoin: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Float
    let highestPricePerLastDay: Float
    let lowestPricePerLastDay: Float
    let priceChangePercentagePerLastDay: Float
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case highestPricePerLastDay = "high_24h"
        case lowestPricePerLastDay = "low_24h"
        case priceChangePercentagePerLastDay = "price_change_percentage_24h"
    }
    
    
}

