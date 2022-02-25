//
//  CryptoCoinCurrentData.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 13.02.22.
//

import Foundation

struct CryptoCoinCurrentData: Decodable {
    let id: String
    let symbol: String
    let name: String
    let hashingAlgorithm: String?
    let image: Image
    let description: Description
    let marketData: MarketData
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case hashingAlgorithm = "hashing_algorithm"
        case image = "image"
        case description = "description"
        case marketData = "market_data"
    }
}

struct MarketData: Decodable {
    let currentPrice: CurrentPrice
    let priceChangePerLastDay: Float
    let priceChangePercentagePerLastDay: Float
    
    private enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case priceChangePerLastDay = "price_change_24h"
        case priceChangePercentagePerLastDay = "price_change_percentage_24h"
    }
}

struct CurrentPrice: Decodable {
    let btc: Float
    let usd: Float
    let eth: Float
}

struct Image: Decodable {
    let thumb: URL
    let small: URL
    let large: URL
}


struct Description: Decodable {
    let en: String
    let de: String
    let es: String
    let fr: String
    let it: String
    let pl: String
    let ro: String
    let hu: String
    let nl: String
    let pt: String
    let sv: String
    let vi: String
    let tr: String
}

extension CryptoCoinCurrentData {
    typealias SingleClosure = (CryptoCoinCurrentData) -> Void
    typealias MiltipleClosure = ([CryptoCoinCurrentData]) -> Void
}
