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
        var queryItems: [String : String] {
            [
                "vs_currency": currency,
                "per_page": perPageCount,
                "page": page
            ]
        }
        func decode(_ data: Data) throws -> [CryptoCoin] {
            let decoder = JSONDecoder()
            return try decoder.decode([CryptoCoin].self, from: data)
        }
        
        let currency: String
        let perPageCount: String
        let page: String
        
        init(currency: String, perPageCount: Int, page: Int) {
            self.currency = currency
            self.perPageCount = String(perPageCount)
            self.page = String(page)
            self.url = baseURL + "/coins/markets"
        }
    }
    
    struct CryptoCoinCurrentDataRequest: DataRequest {
        var url: String
        var method: HTTPMethod { .get }
        var queryItems: [String : String] { [:] }
        func decode(_ data: Data) throws -> CryptoCoinCurrentData {
            let decoder = JSONDecoder()
            return try decoder.decode(CryptoCoinCurrentData.self, from: data)
        }
        
        init(id: String) {
            self.url = baseURL + "/coins/\(id)"
        }
    }
    
    
}
