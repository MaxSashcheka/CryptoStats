//
//  CoinTableViewCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 26.02.22.
//

import UIKit
import SnapKit

class AddCryptoCoinCell: TableCell {
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.custom(font: .montserrat, size: 20, type: .medium)
        return label
    }()
    
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    
    var viewModel: AddCryptoCoinCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            coinImageView.imageFromUrl(url: viewModel.imageURL)
            titleLabel.text = viewModel.name
            checkMarkImageView.isHidden = !viewModel.isSelected
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        selectionStyle = .none
        
        contentView.addSubview(coinImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkMarkImageView)
        
        coinImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.size.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(coinImageView.snp.trailing).offset(15)
        }
        
        checkMarkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(30)
        }
    }
    
}
