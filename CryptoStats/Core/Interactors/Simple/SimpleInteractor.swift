//
//  SimpleInteractor.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import Foundation

class SimpleInteractor: SimpleInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - SimpleInteractorProtocol
extension SimpleInteractor {
    func getSupportedCurrencies(success: @escaping ([String]) -> Void, failure: @escaping ErrorClosure) {
        let request = Requests.SupportedCurrenciesRequest()
        networkService.request(request) { result in
            switch result {
            case .success(let currencies):
                success(currencies)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
