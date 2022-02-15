//
//  CoinDetailsViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit
import RxCocoa
import RxSwift

class CoinDetailsViewController: ViewController {
    
    
    @IBOutlet var contentViews: [UIView]! {
        didSet {
            contentViews.forEach {
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 30
                $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                $0.layer.shadowOffset = .zero
                $0.layer.shadowRadius = 3
                $0.layer.shadowOpacity = 1
            }
        }
    }
    
    @IBOutlet weak var coinImageView: UIImageView! {
        didSet {
            coinImageView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var symbolLabel: UILabel! {
        didSet {
            symbolLabel.font = UIFont.custom(font: .montserrat, size: 40, type: .bold)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.custom(font: .montserrat, size: 25, type: .bold)
            nameLabel.textColor = .gray
        }
    }
    @IBOutlet weak var currentPriceLabel: UILabel! {
        didSet {
            currentPriceLabel.font = UIFont.custom(font: .montserrat, size: 18, type: .medium)
            currentPriceLabel.textColor = .darkGray
        }
    }
    @IBOutlet weak var priceChangeLabel: UILabel!

    @IBOutlet weak var descriptionTitleLabel: UILabel! {
        didSet {
            descriptionTitleLabel.font = UIFont.custom(font: .montserrat, size: 25, type: .bold)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.custom(font: .montserrat, size: 20, type: .regular)
            descriptionLabel.textColor = .darkGray
        }
    }
    
    
    weak var coordinator: CoinsCoordinator?
    var viewModel: CoinDetailsViewModel!
    
    override var isTabBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        viewModel.fetchDetailInfo()
    }
    
    override func bindData() {
        viewModel.coinImageURL
            .asDriver()
            .drive(onNext: { [weak self] url in
                if let url = url { self?.coinImageView.imageFromUrl(url: url) }
            })
            .disposed(by: disposeBag)
        
        viewModel.symbolText
            .asDriver()
            .drive(symbolLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.nameText
            .asDriver()
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.currentPriceText
            .asDriver()
            .drive(currentPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.priceChangeText
            .asDriver()
            .drive(priceChangeLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.descriptionText
            .asDriver()
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }


}
