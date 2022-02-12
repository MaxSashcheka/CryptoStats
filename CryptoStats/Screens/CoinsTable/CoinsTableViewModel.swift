//
//  CoinsTableViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation
import RxCocoa
import RxRelay

class CoinsTableViewModel {
    
    private let networkService: NetworkService

    var cryptoCoins = [CryptoCoin]()
    var cryptoCoinsViewModels = BehaviorRelay<[CryptoCoinViewModel]>(value: [])
    
    var cryptoCoinClickedClosure: VoidClosure? // Change void to another type
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCryptoCoins() {
        let request = Requests.CryptoCoinsRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let coins):
                print("Success! Fetched \(coins.count) coins")
                self?.cryptoCoins = coins
                self?.setupCellViewModels()
            case .failure(let error):
                print("!!! ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func setupCellViewModels() {
        let viewModels = cryptoCoins.map { cryptoCoin -> CryptoCoinViewModel in
            let cellViewModel = CryptoCoinViewModel(imageURL: cryptoCoin.image,
                                                    symbol: cryptoCoin.symbol,
                                                    name: cryptoCoin.name,
                                                    currentPrice: cryptoCoin.currentPrice,
                                                    highestPricePerLastDay: cryptoCoin.highestPricePerLastDay,
                                                    lowestPricePerLastDay: cryptoCoin.lowestPricePerLastDay,
                                                    priceChangePercentagePerLastDay: cryptoCoin.priceChangePercentagePerLastDay)
            
            return cellViewModel
        }
        
        cryptoCoinsViewModels.accept(viewModels)
    }
    
}
