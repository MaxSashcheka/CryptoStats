//
//  CoinsInteractor.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class CoinsInteractor: CoinsInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// CoinsInteractorProtocol

extension CoinsInteractor {
    // Make currency enum
    func getCryptoCoins(forCurrency currency: String, perPageCount: Int, page: Int,
                        success: @escaping CryptoCoin.MultipleClosure,
                        failure: @escaping ErrorClosure) {
        let request = Requests.CryptoCoinsRequest(currency: currency, perPageCount: perPageCount, page: page)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let coins):
                success(coins)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
