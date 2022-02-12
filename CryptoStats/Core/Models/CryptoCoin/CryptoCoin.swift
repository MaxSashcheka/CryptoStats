//
//  Coin.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

struct CryptoCoin: Codable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Int
}

