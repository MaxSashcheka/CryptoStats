//
//  WalletAddCoinViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 26.02.22.
//

import Foundation
import RxCocoa
import RxSwift

class WalletAddCoinViewModel {
    
    private let coinsInteractor: CoinsInteractorProtocol

    var cryptoCoins = [CryptoCoin]()
    var cryptoCoinsViewModels = BehaviorRelay<[AddCryptoCoinCellViewModel]>(value: [])
    let dataStoreManager = DataStoreManager()
    
    var dismissTransition: VoidClosure?
    
    var numberOfItems: Int {
        cryptoCoinsViewModels.value.count
    }
    
    var selectedCoins: [CryptoCoin] {
        let selectedCoins = cryptoCoinsViewModels.value.compactMap { coin -> AddCryptoCoinCellViewModel? in
            return coin.isSelected ? coin : nil
        }
        return selectedCoins.map { addCryptoCoinCellViewModel -> CryptoCoin in
            CryptoCoin(id: addCryptoCoinCellViewModel.id,
                       symbol: addCryptoCoinCellViewModel.symbol,
                       name: addCryptoCoinCellViewModel.name,
                       image: addCryptoCoinCellViewModel.imageURL,
                       currentPrice: addCryptoCoinCellViewModel.currentPrice,
                       highestPricePerLastDay: addCryptoCoinCellViewModel.highestPricePerLastDay,
                       lowestPricePerLastDay: addCryptoCoinCellViewModel.lowestPricePerLastDay,
                       priceChangePercentagePerLastDay: addCryptoCoinCellViewModel.priceChangePercentagePerLastDay,
                       marketCapRank: addCryptoCoinCellViewModel.marketCapRank)
        }
    }
    
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
    
    func setupCellViewModels() {
        let viewModels = cryptoCoins.map { cryptoCoin -> AddCryptoCoinCellViewModel in
            let cellViewModel = AddCryptoCoinCellViewModel(id: cryptoCoin.id,
                                                           imageURL: cryptoCoin.image,
                                                           symbol: cryptoCoin.symbol,
                                                           name: cryptoCoin.name,
                                                           currentPrice: cryptoCoin.currentPrice,
                                                           highestPricePerLastDay: cryptoCoin.highestPricePerLastDay,
                                                           lowestPricePerLastDay: cryptoCoin.lowestPricePerLastDay,
                                                           priceChangePercentagePerLastDay: cryptoCoin.priceChangePercentagePerLastDay,
                                                           isSelected: false,
                                                           marketCapRank: cryptoCoin.marketCapRank)
            
            return cellViewModel
        }
        
        cryptoCoinsViewModels.accept(viewModels)
    }
    
    func selectItem(at indexPath: IndexPath) {
        let viewModels = cryptoCoinsViewModels.value
        viewModels[indexPath.row].isSelected = !viewModels[indexPath.row].isSelected
        cryptoCoinsViewModels.accept(viewModels)
    }
    
    func addCoins() {
        let selectedCoins = selectedCoins
        try? dataStoreManager.createOrUpdateCryptoCoins(selectedCoins)
        dismissTransition?()
    }
    
}
