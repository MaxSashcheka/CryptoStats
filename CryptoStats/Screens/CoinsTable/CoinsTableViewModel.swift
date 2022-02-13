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
    
    private let networkService: NetworkServiceProtocol

    var cryptoCoins = [CryptoCoin]()
    var cryptoCoinsViewModels = BehaviorRelay<[CryptoCoinViewModel]>(value: [])
    
    var showCryptoCoinDetailsTransition: StringClosure? 
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCryptoCoins() {
        let request = Requests.CryptoCoinsRequest(currency: "usd")
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let coins):
                print("SUCCESSFUL RESPONCE! Fetched \(coins.count) coins")
                self?.cryptoCoins = coins
                self?.setupCellViewModels()
            case .failure(let error):
                print("!!! ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func setupCellViewModels() {
        let viewModels = cryptoCoins.map { cryptoCoin -> CryptoCoinViewModel in
            let cellViewModel = CryptoCoinViewModel(id: cryptoCoin.id,
                                                    imageURL: cryptoCoin.image,
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
    
    func selectItem(atIndex index: Int) {
        let cryptoCoinId = cryptoCoinsViewModels.value[index].id
        showCryptoCoinDetailsTransition?(cryptoCoinId)
    }
    
}
