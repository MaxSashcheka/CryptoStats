//
//  CoinsInteractorProtocol.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 14.02.22.
//

import Foundation

protocol CoinsInteractorProtocol {
    func getCryptoCoins(forCurrency currency: String, perPageCount: Int, page: Int,
                        success: @escaping CryptoCoin.MultipleClosure,
                        failure: @escaping ErrorClosure)
}
