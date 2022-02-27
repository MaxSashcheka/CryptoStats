//
//  WalletCoinCollectionViewCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 25.02.22.
//

import UIKit

class WalletCoinCollectionViewCell: UICollectionViewCell {

    // Move nib to base class
    static let reuseIdentifier = "WalletCoinCollectionViewCell"
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }

    
    @IBOutlet weak var coinImageView: UIImageView!
    
    @IBOutlet weak var symbolNameLabel: UILabel! {
        didSet {
            symbolNameLabel.font = UIFont.custom(font: .montserrat, size: 22, type: .bold)
            symbolNameLabel.textColor = .black
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.custom(font: .montserrat, size: 19, type: .medium)
            nameLabel.textColor = .gray
        }
    }
    
    @IBOutlet weak var numberOfCoinLabel: UILabel! {
        didSet {
            numberOfCoinLabel.font = UIFont.custom(font: .montserrat, size: 19, type: .medium)
            numberOfCoinLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var totalCoinPriceLabel: UILabel! {
        didSet {
            totalCoinPriceLabel.font = UIFont.custom(font: .montserrat, size: 19, type: .medium)
            totalCoinPriceLabel.textColor = .gray
        }
    }
    
    @IBOutlet weak var percentageFromAllWalletLabel: UILabel! {
        didSet {
            percentageFromAllWalletLabel.font = UIFont.custom(font: .montserrat, size: 19, type: .medium)
            percentageFromAllWalletLabel.textColor = .gray
        }
    }
    
    @IBOutlet weak var currentCoinPriceLabel: UILabel! {
        didSet {
            currentCoinPriceLabel.font = UIFont.custom(font: .montserrat, size: 19, type: .medium)
            currentCoinPriceLabel.textColor = .gray
        }
    }
    
    @IBOutlet weak var separatorLine: UIView! {
        didSet {
            separatorLine.backgroundColor = .systemGray2
            separatorLine.layer.cornerRadius = 0.5
        }
    }
    
    var viewModel: WalletCoinViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            coinImageView.imageFromUrl(url: viewModel.imageURL)
            symbolNameLabel.text = viewModel.symbol
            nameLabel.text = viewModel.name
            numberOfCoinLabel.text = String(viewModel.count)
            totalCoinPriceLabel.text = "$ \(viewModel.count * viewModel.currentPrice)"
            percentageFromAllWalletLabel.text = "50 %"
            currentCoinPriceLabel.text = "$ \(viewModel.currentPrice)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    private func initialize() {

        backgroundColor = .white
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.cornerRadius = 20
    }
    
}
