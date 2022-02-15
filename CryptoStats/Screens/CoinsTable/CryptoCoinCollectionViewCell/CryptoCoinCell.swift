//
//  CryptoCoinCollectionViewCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

class CryptoCoinCell: UICollectionViewCell {

    static let reuseIdentifier = "CryptoCoinCell"
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
    
    @IBOutlet weak var coinImageView: UIImageView! {
        didSet {
            coinImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var symbolLabel: UILabel! {
        didSet {
            symbolLabel.font = UIFont.custom(font: .montserrat, size: 23, type: .bold)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.custom(font: .montserrat, size: 16, type: .bold)
            nameLabel.textColor = UIColor.gray
        }
    }
    @IBOutlet weak var currentPriceLabel: UILabel! {
        didSet {
            currentPriceLabel.font = UIFont.custom(font: .montserrat, size: 20, type: .bold)
            currentPriceLabel.textColor = .darkGray
        }
    }
    @IBOutlet weak var priceChangePercentageLabel: UILabel! {
        didSet {
            priceChangePercentageLabel.font = UIFont.custom(font: .montserrat, size: 16, type: .bold)
//            priceChangePercentageLabel.textColor = .green
        }
    }
    
    var viewModel: CryptoCoinViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            coinImageView.imageFromUrl(url: viewModel.imageURL)
            symbolLabel.text = viewModel.symbol.uppercased()
            nameLabel.text = viewModel.name
            currentPriceLabel.text = "\(viewModel.currentPrice) $"
            priceChangePercentageLabel.text = "\(viewModel.priceChangePercentagePerLastDay) %"
            
            priceChangePercentageLabel.textColor = viewModel.priceChangePercentagePerLastDay > 0 ? .green : .red
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .white
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.cornerRadius = 20
        
    }
    
    

}
