//
//  CoinDetailsViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class CoinDetailsViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let selectedCoinId: String
    
    init(networkService: NetworkServiceProtocol, selectedCoinId: String) {
        self.networkService = networkService
        self.selectedCoinId = selectedCoinId
    }
    
    func fetchDetailInfo() {
        let request = Requests.CryptoCoinCurrentDataRequest(id: selectedCoinId)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let cryptoCoinCurrentData):
                print("Success!!!!!")
                print(cryptoCoinCurrentData)
            case .failure(let error):
                print("!!! ERROR: \(error.localizedDescription)")
            }
        }
    }
}
