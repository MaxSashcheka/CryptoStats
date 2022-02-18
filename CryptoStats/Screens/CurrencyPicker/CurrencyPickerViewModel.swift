//
//  CurrencyPickerViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class CurrencyPickerViewModel {
    
    var simpleInteractor: SimpleInteractorProtocol
    
    var curreniesViewModels = BehaviorRelay<[CurrencyPickerCellViewModel]>(value: [])
    
    var numberOfItems: Int {
        curreniesViewModels.value.count
    }
    
    init(simpleInteractor: SimpleInteractorProtocol) {
        self.simpleInteractor = simpleInteractor
        setupCellViewModels()
    }
    
    func selectCell(at indexPath: IndexPath) {
        curreniesViewModels.value[indexPath.row].isSelected = true
        let updatedCurrenciesViewModels = curreniesViewModels.value
        
        for (index, viewModel) in updatedCurrenciesViewModels.enumerated() {
            viewModel.isSelected = index == indexPath.row ? true : false
        }
        curreniesViewModels.accept(updatedCurrenciesViewModels)

    }
}

private extension CurrencyPickerViewModel {
    func setupCellViewModels() {
        simpleInteractor.getSupportedCurrencies { [weak self] currencies in
            let cellsViewModels = currencies.map { title -> CurrencyPickerCellViewModel in
                let attributedTitle = NSAttributedString(string: title.uppercased(), attributes: [.font: UIFont.systemFont(ofSize: 23, weight: .regular),
                                                                                     .foregroundColor: UIColor.black])
                let isSelected = title == "usd" ? true : false
                
                return CurrencyPickerCellViewModel(title: attributedTitle, isSelected: isSelected)
            }
            self?.curreniesViewModels.accept(cellsViewModels)
        } failure: { error in
            print("Error: \(error.localizedDescription)")
        }

    }
}
