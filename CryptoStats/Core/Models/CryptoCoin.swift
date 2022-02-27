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
    let marketCapRank: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case highestPricePerLastDay = "high_24h"
        case lowestPricePerLastDay = "low_24h"
        case priceChangePercentagePerLastDay = "price_change_percentage_24h"
        case marketCapRank = "market_cap_rank"
    }
    
}

extension CryptoCoin {
    init(cryptoCoinEntity: CryptoCoinEntity) {
        self.id = cryptoCoinEntity.id!
        self.symbol = cryptoCoinEntity.symbol!
        self.name = cryptoCoinEntity.name!
        self.image = URL(string: cryptoCoinEntity.image!)!
        self.currentPrice = cryptoCoinEntity.currentPrice
        self.highestPricePerLastDay = cryptoCoinEntity.highestPricePerLastDay
        self.lowestPricePerLastDay = cryptoCoinEntity.lowestPricePerLastDay
        self.priceChangePercentagePerLastDay = cryptoCoinEntity.priceChangePercentagePerLastDay
        self.marketCapRank = Int(cryptoCoinEntity.marketCapRank)
    }
}

// MARK: - Closures

extension CryptoCoin {
    typealias SingleClosure = (CryptoCoin) -> Void
    typealias MultipleClosure = ([CryptoCoin]) -> Void
}


