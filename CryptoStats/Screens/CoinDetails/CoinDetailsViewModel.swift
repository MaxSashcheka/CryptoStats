//
//  CoinDetailsViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit
import RxCocoa
import RxRelay

class CoinDetailsViewModel {
    
    private let networkService: NetworkServiceProtocol
    private let selectedCoinId: String
    
    init(networkService: NetworkServiceProtocol, selectedCoinId: String) {
        self.networkService = networkService
        self.selectedCoinId = selectedCoinId
    }
    
    var coinImageURL = BehaviorRelay<URL?>(value: nil)
    var symbolText = BehaviorRelay<String>(value: "")
    var nameText = BehaviorRelay<String>(value: "")
    var currentPriceText = BehaviorRelay<String>(value: "")
    var priceChangeText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    var descriptionText = BehaviorRelay<String>(value: "")
    
    func fetchDetailInfo() {
        let request = Requests.CryptoCoinCurrentDataRequest(id: selectedCoinId)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cryptoCoinCurrentData):
                self.coinImageURL.accept(cryptoCoinCurrentData.image.large)
                self.symbolText.accept(cryptoCoinCurrentData.symbol.uppercased())
                self.nameText.accept(cryptoCoinCurrentData.name)
                self.currentPriceText.accept("Price: \(cryptoCoinCurrentData.marketData.currentPrice.usd) $")
                
                let priceChangePerLastDayBaseString = "Price change: \n"
                let priceChangePerLastDayString = "\(cryptoCoinCurrentData.marketData.priceChangePerLastDay)"
                let priceChangePerLastDayInPercentages = "(\(cryptoCoinCurrentData.marketData.priceChangePercentagePerLastDay) %)"
                let priceChangeAttributedString = "\(priceChangePerLastDayBaseString) \(priceChangePerLastDayString) \(priceChangePerLastDayInPercentages)"
                    .coloredAttributedText(coloredString: "\(priceChangePerLastDayString) \(priceChangePerLastDayInPercentages)",
                                           baseColor: .darkGray,
                                           color: cryptoCoinCurrentData.marketData.priceChangePerLastDay > 0 ? .green : .red,
                                           font: .montserrat,
                                           type: .medium,
                                           size: 18)
                
                self.priceChangeText.accept(priceChangeAttributedString)
                if cryptoCoinCurrentData.description.en.isEmpty {
                    self.descriptionText.accept("No description")
                } else {
                    self.descriptionText.accept(cryptoCoinCurrentData.description.en)
                }
                
                
            case .failure(let error):
                print("!!! ERROR: \(error.localizedDescription)")
            }
        }
    }
}

