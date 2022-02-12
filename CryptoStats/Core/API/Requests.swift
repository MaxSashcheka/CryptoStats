//
//  Requests.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

class Requests {
    static let baseURL = "https://api.coingecko.com/api/v3"
    
    struct CryptoCoinsRequest: DataRequest {
        var url: String
        var method: HTTPMethod { .get }
        var queryItems: [String : String]
        func decode(_ data: Data) throws -> [CryptoCoin] {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-mm-dd"
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let response = try decoder.decode([CryptoCoin].self, from: data)
            return response
        }
        
        init(currency: String) {
            self.queryItems = ["vs_currency": currency]
            self.url = baseURL + "/coins/markets"
        }
    }
    
    struct CryptoCoinCurrentDataRequest: DataRequest {
        var url: String
        var method: HTTPMethod { .get }
        var queryItems: [String : String]
        func decode(_ data: Data) throws -> [CryptoCoin] {
            let decoder = JSONDecoder()
            let response = try decoder.decode([CryptoCoin].self, from: data)
            return response
        }
        
        init(id: String) {
            self.queryItems = [:]
            self.url = baseURL + id
        }
    }
    
    
}
