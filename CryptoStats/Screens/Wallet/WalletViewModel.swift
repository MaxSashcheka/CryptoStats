//
//  WalletViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import Foundation
import RxCocoa
import RxRelay

class WalletViewModel {
    
    private let coinsInteractor: CoinsInteractorProtocol
    var dataStoreManager = DataStoreManager()

    var showAddCoinTransition: VoidClosure?
    var walletCoinsViewModels = BehaviorRelay<[WalletCoinViewModel]>(value: [])
    var walletInfoViewModel = BehaviorRelay<WalletInfoViewModel>(value: WalletInfoViewModel(totalPrice: 0))
    var totalPrice = BehaviorRelay<Float>(value: 0)
    
    var cryptoCoinsEntities = [CryptoCoinEntity]()

    var numberOfSections: Int {
        return 2
    }
    
    init(coinsInteractor: CoinsInteractorProtocol) {
        self.coinsInteractor = coinsInteractor
        
        setupViewModels()
    }
    
    func setupViewModels() {
        let cryptoCoins = dataStoreManager.fetchCryptoCoins()
        let viewModels = cryptoCoins.map { cryptoCoinEntity -> WalletCoinViewModel in
            let cellViewModel = WalletCoinViewModel(id: cryptoCoinEntity.id!,
                                                    imageURL: URL(string: cryptoCoinEntity.image!)!,
                                                    symbol: cryptoCoinEntity.symbol!.uppercased(),
                                                    name: cryptoCoinEntity.name!,
                                                    currentPrice: cryptoCoinEntity.currentPrice,
                                                    highestPricePerLastDay: cryptoCoinEntity.highestPricePerLastDay,
                                                    lowestPricePerLastDay: cryptoCoinEntity.lowestPricePerLastDay,
                                                    priceChangePercentagePerLastDay: cryptoCoinEntity.priceChangePercentagePerLastDay,
                                                    count: cryptoCoinEntity.count,
                                                    marketCapRank: Int(cryptoCoinEntity.marketCapRank))
            return cellViewModel
        }
        
        walletCoinsViewModels.accept(viewModels)
        calculateTotalPrice()
        
    }
    
    func calculateTotalPrice() {
        var tempTotalPrice: Float = 0
        for coinViewModel in walletCoinsViewModels.value {
            tempTotalPrice += coinViewModel.currentPrice * coinViewModel.count
        }
        walletInfoViewModel.accept(WalletInfoViewModel(totalPrice: tempTotalPrice))
        
    }
    
    func numberOfItems(for section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return walletCoinsViewModels.value.count
        }
    }
    
//    func fetchAPICryptoCoins() {
//        coinsInteractor.getCryptoCoins(forCurrency: "usd", perPageCount: 30, page: 1) { [weak self] coins in
//            self?.cryptoCoins = coins
//            self?.setupCellViewModels()
//        } failure: { error in
//            print("ERROR! \(error.localizedDescription)")
//        }
//    }
    
}
