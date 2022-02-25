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
    
    private let coinsInteractor: CoinsInteractorProtocol

    var cryptoCoins = [CryptoCoin]()
    var cryptoCoinsViewModels = BehaviorRelay<[CryptoCoinViewModel]>(value: [])
    var isActivityIndicatorShown = BehaviorRelay(value: false)
    
    var showCryptoCoinDetailsTransition: CryptoCoinCurrentData.SingleClosure?
    
    init(coinsInteractor: CoinsInteractorProtocol) {
        self.coinsInteractor = coinsInteractor
    }
    
    func fetchCryptoCoins() {
        coinsInteractor.getCryptoCoins(forCurrency: "usd", perPageCount: 30, page: 1) { [weak self] coins in
            self?.cryptoCoins = coins
            self?.setupCellViewModels()
        } failure: { error in
            print("ERROR! \(error.localizedDescription)")
        }
    }
    
    func fetchCryptoCoin(withId coinId: String) {
        
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
        isActivityIndicatorShown.accept(true)
        
        let cryptoCoinId = cryptoCoinsViewModels.value[index].id
        coinsInteractor.getCryptoCoinDetails(coinId: cryptoCoinId) { [weak self] cryptoCoinCurrentData in
            DispatchQueue.main.async {
                self?.showCryptoCoinDetailsTransition?(cryptoCoinCurrentData)
                self?.isActivityIndicatorShown.accept(false)
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.isActivityIndicatorShown.accept(false)
                print("Failed to fetch crypto coin current data")
            }

        }
        
    }
    
}
