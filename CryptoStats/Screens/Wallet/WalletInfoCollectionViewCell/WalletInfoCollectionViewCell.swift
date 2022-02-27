//
//  WalletInfoCollectionViewCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 25.02.22.
//

import UIKit

class WalletInfoCollectionViewCell: UICollectionViewCell {

    // Move nib to base class
    static let reuseIdentifier = "WalletInfoCollectionViewCell"
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
    
    var showAddCoinScreenTransition: VoidClosure?
    
    @IBOutlet weak var totalBalanceTitleLabel: UILabel! {
        didSet {
            totalBalanceTitleLabel.font = UIFont.custom(font: .montserrat, size: 24, type: .bold)
            totalBalanceTitleLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var todayInfoLabel: UILabel! {
        didSet {
            todayInfoLabel.font = UIFont.custom(font: .montserrat, size: 20, type: .medium)
            todayInfoLabel.textColor = .gray
            
            let dateFormatter = DateFormatter.infoDateFormatter
            todayInfoLabel.text = "Today, \(dateFormatter.string(from: Date()))"
        }
    }

    @IBOutlet weak var totalBalanceLabel: UILabel! {
        didSet {
//            totalBalanceLabel.attributedText =
        }
    }
    
    @IBOutlet weak var addCoinContentView: UIView! {
        didSet {
            addCoinContentView.layer.cornerRadius = 12
            addCoinContentView.backgroundColor = .clear
            addCoinContentView.layer.borderColor = UIColor.black.cgColor
            addCoinContentView.layer.borderWidth = 1.5
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addCoin))
            addCoinContentView.addGestureRecognizer(tapRecognizer)
        }
    }

    @IBOutlet weak var plusImageView: UIImageView! {
        didSet {
            plusImageView.tintColor = .black
        }
    }
    @IBOutlet weak var addCoinTitleLabel: UILabel! {
        didSet {
            addCoinTitleLabel.text = "ADD COIN"
            addCoinTitleLabel.textColor = .black
            addCoinTitleLabel.font = UIFont.custom(font: .montserrat, size: 22, type: .medium)
        }
    }
    
    var viewModel: WalletInfoViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            totalBalanceLabel.attributedText = makeAttributedTotalBalanceText("$ \(viewModel.totalPrice)", currencyString: "$ ")
        }
    }
    
    private var tapRecognizer: UITapGestureRecognizer!
    
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
    
    @objc private func addCoin() {
        showAddCoinScreenTransition?()
    }
    
}

private extension WalletInfoCollectionViewCell {
    func makeAttributedTotalBalanceText(_ balanceString: String, currencyString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: balanceString,
                                                         attributes:
                                                            [NSAttributedString.Key.font: UIFont.custom(font: .montserrat, size: 60, type: .regular),
                                                             NSAttributedString.Key.foregroundColor: UIColor.black.cgColor
                                                         ])
        let currencyAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.custom(font: .montserrat, size: 25, type: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.cgColor
        ]
    
        let range = (balanceString as NSString).range(of: currencyString)
        attributedString.addAttributes(currencyAttribute, range: range)
        
        var dotRange = (balanceString as NSString).range(of: ".")
        dotRange.length = balanceString.count - dotRange.location
        attributedString.addAttributes(currencyAttribute, range: dotRange)
        
        return attributedString
    }
}

