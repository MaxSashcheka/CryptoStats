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
    let hashingAlgorithm: String
    let image: Image
    let description: Description
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case hashingAlgorithm = "hashing_algorithm"
        case image = "image"
        case description = "description"
    }
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
