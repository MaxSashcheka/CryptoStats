//
//  CoinDetailsViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit

class CoinDetailsViewController: ViewController {

    weak var coordinator: CoinsCoordinator?
    
    var viewModel: CoinDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchDetailInfo()
    }


}
