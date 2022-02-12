//
//  Requests.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

class Requests {
    struct CryptoCoinsRequest: DataRequest {
        var url: String {
            let baseURL: String = "https://api.coingecko.com/api/v3"
            let path: String = "/coins/markets"
            return baseURL + path
        }
        var queryItems: [String : String] {
            [
                "vs_currency": "USD"
            ]
        }
        var method: HTTPMethod { .get }
        
        func decode(_ data: Data) throws -> [CryptoCoin] {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-mm-dd"
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let response = try decoder.decode([CryptoCoin].self, from: data)
            print(response.first)
            return response
        }
    }
    
//    struct ImageRequest: DataRequest {
//        let url: String
//        var method: HTTPMethod { .get }
//
//        func decode(_ data: Data) throws -> UIImage {
//            guard let image = UIImage(data: data) else {
//                throw NSError(
//                    domain: "Invalid responce",
//                    code: 13,
//                    userInfo: nil
//                )
//            }
//            return image
//        }
//    }
}
